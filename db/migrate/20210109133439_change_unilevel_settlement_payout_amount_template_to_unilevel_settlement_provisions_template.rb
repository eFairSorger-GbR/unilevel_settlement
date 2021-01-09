class ChangeUnilevelSettlementPayoutAmountTemplateToUnilevelSettlementProvisionsTemplate < ActiveRecord::Migration[6.0]
  def change
    rename_table :unilevel_settlement_payout_amount_templates, :unilevel_settlement_provisions_templates
  end
end
