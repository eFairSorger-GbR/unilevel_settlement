class CreateUnilevelSettlementPayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_payouts do |t|
      t.string :payout_number
      t.references :unilevel_settlement_payout_run, null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_payout_on_payout_runs_id' }

      t.timestamps
    end
  end
end
