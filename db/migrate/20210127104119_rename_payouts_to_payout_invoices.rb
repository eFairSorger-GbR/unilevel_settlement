class RenamePayoutsToPayoutInvoices < ActiveRecord::Migration[6.0]
  def up
    rename_table :unilevel_settlement_payouts, :unilevel_settlement_payout_invoices
  end

  def down
    rename_table :unilevel_settlement_payout_invoices, :unilevel_settlement_payouts
  end
end
