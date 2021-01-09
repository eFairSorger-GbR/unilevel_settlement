module UnilevelSettlement
  class Provider < ApplicationRecord
    include UnilevelSettlement::DelegateAttributes

    belongs_to :payout_amount_template, optional: true
    has_many :contracts

    delegate_if_not_set :provisions, to: :payout_amount_template
  end
end
