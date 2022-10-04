class DonationBlockchainTransactionBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :chain_id, :transaction_hash, :status
end
