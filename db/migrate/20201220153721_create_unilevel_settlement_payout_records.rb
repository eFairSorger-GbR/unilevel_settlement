class CreateUnilevelSettlementPayoutRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_payout_records do |t|
      t.decimal :amount
      t.decimal :vat
      t.string :contract_id
      t.bigint :level
      t.references :unilevel_settlement_payout, null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_payout_record_on_payout' }

      t.timestamps
    end
  end
end
