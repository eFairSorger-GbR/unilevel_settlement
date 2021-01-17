module UnilevelSettlement
  class Provision < ApplicationRecord
    belongs_to :provider, optional: true
    belongs_to :provisions_template, optional: true

    validates :level, presence: true
    validates :provision, presence: true, numericality: { greater_thatn_or_equal_to: 0 }
    validates :provider, level_uniqueness: true
    validates :provisions_template, level_uniqueness: true

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
