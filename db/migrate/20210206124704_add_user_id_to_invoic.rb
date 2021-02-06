class AddUserIdToInvoic < ActiveRecord::Migration[6.0]
  def change
    add_column :unilevel_settlement_payout_invoices, :user_id, :integer
  end
end
