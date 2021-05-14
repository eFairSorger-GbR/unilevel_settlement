module UnilevelSettlement
  class Contract < ApplicationRecord
    belongs_to :provider, class_name: 'UnilevelSettlement::Provider', foreign_key: 'unilevel_settlement_provider_id',
                          optional: true, inverse_of: :contracts
    belongs_to :user, class_name: UnilevelSettlement.user_class.to_s, foreign_key: 'user_id', optional: false,
                      inverse_of: :contracts

    has_many :records, class_name: 'UnilevelSettlement::PayoutRecord', foreign_key: 'unilevel_settlement_contract_id',
                       inverse_of: :contract

    validates :contract_number, uniqueness: { scope: %i[rejected cancellation] }
  end
end
