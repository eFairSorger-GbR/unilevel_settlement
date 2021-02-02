module UnilevelSettlement
  class Contract < ApplicationRecord
    belongs_to :provider, class_name: 'UnilevelSettlement::Provider', foreign_key: 'unilevel_settlement_provider_id',
                          optional: true, inverse_of: :contracts
    belongs_to :user, class_name: UnilevelSettlement.user_class.to_s, foreign_key: 'user_id'
    has_many :payout_records

    validates :contract_number, uniqueness: { scope: :rejected }
    validates :contract_number, uniqueness: { scope: :cancellation }
  end
end
