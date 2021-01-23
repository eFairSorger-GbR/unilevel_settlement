module UnilevelSettlement
  class ProvisionsTemplate < ApplicationRecord
    has_many :providers, class_name: 'UnilevelSettlement::Provider',
                         foreign_key: 'unilevel_settlement_provisions_template_id'
    has_many :provisions, class_name: 'UnilevelSettlement::Provision',
                          foreign_key: 'unilevel_settlement_provisions_template_id', inverse_of: :provisions_template

    accepts_nested_attributes_for :provisions, reject_if: :all_blank, allow_destroy: true

    validates :name, presence: true
    validate :provisions_must_exist

    private

    def provisions_must_exist
      return if provisions.any?

      errors.add(:provisions, 'Es müssen Provisionen existieren')
    end
  end
end
