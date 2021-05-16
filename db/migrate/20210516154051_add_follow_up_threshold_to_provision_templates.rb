class AddFollowUpThresholdToProvisionTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_provisions_templates, :follow_up_threshold, :decimal
  end
end
