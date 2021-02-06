class ChangePayoutNumberToInvoiceNumberOnInvoices < ActiveRecord::Migration[6.0]
  def change
    rename_column :unilevel_settlement_payout_invoices, :payout_number, :invoice_number
  end
end
