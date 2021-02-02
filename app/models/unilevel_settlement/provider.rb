# frozen_string_literal: true

module UnilevelSettlement
  class Provider < ApplicationRecord
    include UnilevelSettlement::DelegateAttributes

    belongs_to :provisions_template, class_name: 'UnilevelSettlement::ProvisionsTemplate',
                                     foreign_key: 'unilevel_settlement_provisions_template_id', optional: true

    has_many :provisions, -> { order(level: :asc) }, class_name: 'UnilevelSettlement::Provision',
                                                     foreign_key: 'unilevel_settlement_provider_id',
                                                     inverse_of: :provider, dependent: :destroy

    has_many :contracts, class_name: 'UnilevelSettlement::Contract',
                         foreign_key: 'unilevel_settlement_provider_id',
                         inverse_of: :provider

    accepts_nested_attributes_for :provisions, reject_if: :all_blank, allow_destroy: true

    validates :name, presence: true, uniqueness: true
    validate :provisions_or_template_must_exist, :only_one_reference_assigned

    private

    def provisions_or_template_must_exist
      return if (provisions.any? && !provisions.all?(&:marked_for_destruction?)) ||
                provisions_template

      errors.add(:provisions_template, 'Provisionen oder Provisions Template muss ausgefüllt sein')
    end

    def only_one_reference_assigned
      return unless (provisions.any? && !provisions.all?(&:marked_for_destruction?)) &&
                    (provisions_template && !provisions_template.marked_for_destruction?)

      errors.add(:provisions_template, 'Nur entweder Provisionen oder Provisions Template darf ausgefüllt sein')
    end
  end
end
