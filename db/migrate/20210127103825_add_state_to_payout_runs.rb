class AddStateToPayoutRuns < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_payout_runs, :state, :string, default: 'payout_run_started'
  end
end
