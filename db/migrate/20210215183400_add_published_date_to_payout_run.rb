class AddPublishedDateToPayoutRun < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_payout_runs, :published_date, :date, default: nil
  end
end
