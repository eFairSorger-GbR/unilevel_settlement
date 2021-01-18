# frozen_string_literal: true

module UnilevelSettlement
  class Provider < ApplicationRecord
    include UnilevelSettlement::DelegateAttributes

    belongs_to :provisions_template, class_name: 'UnilevelSettlement::ProvisionsTemplate',
                                     foreign_key: 'unilevel_settlement_provisions_template_id', optional: true
    has_many :provisions, class_name: 'UnilevelSettlement::Provision'
    has_many :contracts, class_name: 'UnilevelSettlement::Contract', foreign_key: 'unilevel_settlement_contract_id'

    accepts_nested_attributes_for :provisions, reject_if: :all_blank, allow_destroy: true

    # delegate_if_not_set :provisions, to: :provisions_template
  end
end
