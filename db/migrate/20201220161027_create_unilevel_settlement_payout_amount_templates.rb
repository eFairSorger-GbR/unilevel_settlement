class CreateUnilevelSettlementPayoutAmountTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_payout_amount_templates do |t|
      t.string :name
      t.jsonb :provisions

      t.timestamps
    end
  end
end
