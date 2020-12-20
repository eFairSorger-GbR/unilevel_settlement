class CreateUnilevelSettlementProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_providers do |t|
      t.string :name
      t.jsonb :provisions
      t.boolean :inactive, default: false
      t.references :unilevel_settlement_payout_amount_template, null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_provider_on_payout_amount_template_id' }

      t.timestamps
    end
  end
end
