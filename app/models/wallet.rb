class Wallet < ApplicationRecord
  belongs_to :non_profits, :polymorphic => true
end
