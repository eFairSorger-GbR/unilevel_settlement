class AddFollowUpToContract < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_contracts, :follow_up, :boolean, default: false
  end
end
