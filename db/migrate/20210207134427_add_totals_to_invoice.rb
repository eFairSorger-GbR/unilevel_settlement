class AddTotalsToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_payout_invoices, :sub_total_level0, :decimal
    add_column :unilevel_settlement_payout_invoices, :sub_total_level1, :decimal
    add_column :unilevel_settlement_payout_invoices, :sub_total_level2, :decimal
    add_column :unilevel_settlement_payout_invoices, :sub_total, :decimal
    add_column :unilevel_settlement_payout_invoices, :total_vat, :decimal
    add_column :unilevel_settlement_payout_invoices, :total, :decimal
  end
end
