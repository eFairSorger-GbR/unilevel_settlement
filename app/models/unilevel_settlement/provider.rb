module UnilevelSettlement
  class Provider < ApplicationRecord
    include UnilevelSettlement::DelegateAttributes

    belongs_to :provisions_template, optional: true
    has_many :provisions
    has_many :contracts

    accepts_nested_attributes_for :provisions, reject_if: :all_blank, allow_destroy: true

    # delegate_if_not_set :provisions, to: :provisions_template
  end
end
