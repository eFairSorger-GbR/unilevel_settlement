# frozen_string_literal: true

module UnilevelSettlement
  class Provision < ApplicationRecord
    belongs_to :provider, class_name: 'UnilevelSettlement::Provider', foreign_key: 'unilevel_settlement_provider_id',
                          optional: true, inverse_of: :provisions

    belongs_to :provisions_template, class_name: 'UnilevelSettlement::ProvisionsTemplate',
                                     foreign_key: 'unilevel_settlment_provisions_template_id', optional: true

    validates :level, presence: true
    validates :provision, presence: true, numericality: { greater_thatn_or_equal_to: 0 }

    validates :provider, 'unilevel_settlement/level_uniqueness': true
    validates :provisions_template, 'unilevel_settlement/level_uniqueness': true

    validate :provider_or_template_must_exist, :only_one_reference_assigned

    private

    def provider_or_template_must_exist
      return if provider || provisions_template

      errors.add(:provider, 'Anbieter oder Provisions Template muss ausgefüllt sein')
    end

    def only_one_reference_assigned
      return unless provider && provisions_template

      errors.add(:provider, 'Nur Anbieter oder Provisions Template darf ausgefüllt sein')
    end
  end
end
