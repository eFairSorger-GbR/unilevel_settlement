class AddFollowUpToProvision < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_provisions, :follow_up, :boolean, default: false
  end
end
