class UpdateUserIdNullOnLegacyContributions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :legacy_contributions, :user_id, true
  end
end
