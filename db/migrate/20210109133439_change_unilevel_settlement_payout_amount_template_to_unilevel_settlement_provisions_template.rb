class ChangeUnilevelSettlementPayoutAmountTemplateToUnilevelSettlementProvisionsTemplate < ActiveRecord::Migration[6.0]
  def change
    rename_table :unilevel_settlement_payout_amount_templates, :unilevel_settlement_provisions_templates
    remove_column :unilevel_settlement_providers, :unilevel_settlement_payout_amount_template_id
    add_reference :unilevel_settlement_providers, :unilevel_settlement_provisions_template, index: { name: 'index_unilevel_settlement_provider_on_provision_template_id' }
  end
end
