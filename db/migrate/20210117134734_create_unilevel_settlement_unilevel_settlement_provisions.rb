class CreateUnilevelSettlementUnilevelSettlementProvisions < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_unilevel_settlement_provisions do |t|
      t.decimal :provision
      t.integer :level
      t.references :unilevel_settlement_provider, foreign_key: true, precision: 10, scale: 2, index: { name: 'index_unilevel_settlement_provisions_on_provider_id' }
      t.references :unilevel_settlement_provisions_template, foreign_key: true, precision: 10, scale: 2, index: { name: 'index_unilevel_settlement_provisions_on_provisions_template_id' }

      t.timestamps
    end
  end
end
