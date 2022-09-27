RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.main_app_name = ["Ribon", "Admin"]
  config.parent_controller = RailsAdmin::RailsAdminAbstractController.to_s

  config.authenticate_with do
    # this is a rails controller helper
    authenticate_or_request_with_http_basic('Login required') do |email, password|

      # Here we're checking for username & password provided with basic auth
      resource = Admin.find_by(email: email)

      # we're using devise helpers to verify password and sign in the user
      if resource&.valid_password?(password)
        sign_in :admin, resource
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.included_models = [Admin, UserManager, User, NonProfit, NonProfitImpact, Integration,
                            Donation, RibonConfig, Offer, OfferGateway,
                            Customer, PersonPayment, DonationBlockchainTransaction, Chain,
                            Cause, Story, IntegrationPool, NonProfitPool]

  config.model RibonConfig do
    field :default_ticket_value do
      label{ "ticket value in usdc cents" }
    end

    field :minimum_integration_amount do
      label{ "minimum amount in usdc for new integrations" }
    end

    field :default_chain_id do
      label{ "Default chain id, like polygon or mumbai" }
    end
  end

  config.model DonationBlockchainTransaction do
    include_all_fields

    field :transaction_hash do
      formatted_value do
        path = bindings[:object].transaction_link
        bindings[:view].link_to(bindings[:object].transaction_hash, path, target: "_blank")
      end
    end
  end

  config.model NonProfit do
    field :main_image do
      label{ "Cause Card Image" }
    end

    field :background_image do
      label{ "Support Image" }
    end

    field :logo do
      label{ "Logo" }
    end

    include_all_fields
  end

  config.model NonProfitImpact do
    field :usd_cents_to_one_impact_unit do
      label{ "USD cents to one impact unit (100 = one dollar)" }
    end

    include_all_fields
  end

  MOBILITY_MODELS =  ApplicationRecord.descendants.select{ |model| model.included_modules.include?(Mobility::Plugins::Backend::InstanceMethods) }
  MOBILITY_MODELS.each do |model|
    config.model model do
      edit do
        formatted_mobility_attributes(model)
      end
      show do
        formatted_mobility_attributes(model)
      end

      list do
        fields do
          formatted_value{ bindings[:object].send(method_name) }
        end
      end
    end
  end

end

def formatted_mobility_attributes(model)
  model.mobility_attributes.each do |field_name|
    field field_name.to_sym do
      formatted_value{ bindings[:object].send(method_name) }
      help 'translation field'
      label do
        "#{label} (t)"
      end
    end
  end

  include_all_fields
end
