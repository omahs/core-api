RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.main_app_name = ["Ribon", "Admin"]
  config.parent_controller = RailsAdmin::RailsAdminAbstractController.to_s
  ### Popular gems integration
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
  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.included_models = [User, NonProfit, NonProfitImpact, Integration, Donation]

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
