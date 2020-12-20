class CreateUnilevelSettlementPayoutRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_payout_records do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.decimal :vat, precision: 8, scale: 2
      t.bigint :level
      t.references :unilevel_settlement_payout, null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_payout_record_on_payout' }

      t.timestamps
    end
  end
end
