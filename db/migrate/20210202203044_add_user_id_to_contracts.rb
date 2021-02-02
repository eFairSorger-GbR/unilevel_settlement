class AddUserIdToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_contracts, :user_id, :integer
  end
end
