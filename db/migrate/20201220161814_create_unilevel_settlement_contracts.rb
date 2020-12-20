class CreateUnilevelSettlementContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_contracts do |t|
      t.string :contract_number
      t.boolean :cancellation
      t.string :customer
      t.string :product
      t.references :unilevel_settlement_provider, null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_contract_on_provider_id' }

      t.timestamps
    end
  end
end
