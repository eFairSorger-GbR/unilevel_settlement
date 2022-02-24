class AddRestartToContract < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_contracts, :restart, :boolean, default: false
  end
end
