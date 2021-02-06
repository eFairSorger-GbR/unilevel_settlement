class ChangePayoutInvoiceRelationOnRecords < ActiveRecord::Migration[6.0]
  def change
    remove_column :unilevel_settlement_payout_records, :unilevel_settlement_payout_id
    add_reference :unilevel_settlement_payout_records, :unilevel_settlement_payout_invoice,
                   null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_payout_record_on_invoice_id' }
  end
end
