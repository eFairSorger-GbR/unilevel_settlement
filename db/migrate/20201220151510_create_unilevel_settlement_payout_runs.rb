class CreateUnilevelSettlementPayoutRuns < ActiveRecord::Migration[6.0]
  def change
    create_table :unilevel_settlement_payout_runs do |t|
      t.date :payout_date
      t.date :performance_start_date
      t.date :performance_end_date

      t.timestamps
    end
  end
end
