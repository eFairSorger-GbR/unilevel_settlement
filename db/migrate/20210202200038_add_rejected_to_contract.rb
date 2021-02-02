class AddRejectedToContract < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_contracts, :rejected, :boolean, default: false
  end
end
