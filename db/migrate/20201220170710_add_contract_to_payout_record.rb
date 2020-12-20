class AddContractToPayoutRecord < ActiveRecord::Migration[6.0]
  def change
    add_reference :unilevel_settlement_payout_records, :unilevel_settlement_contract, null: false, foreign_key: true, index: { name: 'index_unilevel_settlement_payout_record_on_contract_id' }
  end
end
