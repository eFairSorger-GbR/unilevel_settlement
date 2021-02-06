module UnilevelSettlement
  class PayoutRecord < ApplicationRecord
    belongs_to :invoice, class_name: 'UnilevelSettlement::PayoutInvoice', foreign_key: 'unilevel_settlement_payout_invoice_id',
                         optional: false, inverse_of: :records
    belongs_to :contract, class_name: 'UnilevelSettlement::Contract', foreign_key: 'unilevel_settlement_contract_id',
                          optional: false, inverse_of: :records

    has_one :user, through: :contract
  end
end
