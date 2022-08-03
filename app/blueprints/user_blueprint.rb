class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :email

  view :extended do
    field :last_donation_at
  end
end
