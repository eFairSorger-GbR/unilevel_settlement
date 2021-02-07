module UnilevelSettlement
  class PayoutRun < ApplicationRecord
    STATES = %w[payout_run_started awaiting_providers awaiting_payout_records].freeze

    has_many :invoices, class_name: 'UnilevelSettlement::PayoutInvoices',
                        foreign_key: 'unilevel_settlement_payout_run_id', inverse_of: :run
    has_many :records, through: :invoices

    has_one_attached :payout_records_source_excel

    validates :payout_date, presence: true
    validates :performance_start_date, presence: true
    validates :performance_end_date, presence: true
    validates :state, inclusion: { in: STATES, message: 'Status ist nicht korrekt' }

    validate :end_date_after_start_date, :payout_date_after_start_date, :excel_attached,
             :payout_records_source_excel_is_excel

    default_scope { order(payout_date: :desc) }

    def payout_records_source_excel_file_path
      ActiveStorage::Blob.service.send(:path_for, payout_records_source_excel.key)
    end

    def cancel
      PayoutRunCancelService.new(self).cancel
    end

    private

    def end_date_after_start_date
      return unless performance_end_date && performance_start_date
      return unless performance_end_date < performance_start_date

      errors.add(:performance_end_date, 'muss nach Start Datum liegen')
    end

    def payout_date_after_start_date
      return unless performance_start_date && payout_date
      return unless payout_date < performance_start_date

      errors.add(:payout_date, 'muss nach Start Datum liegen')
    end

    def excel_attached
      return if payout_records_source_excel.attached?

      errors.add(:payout_records_source_excel, 'muss ausgewählt sein')
    end

    def payout_records_source_excel_is_excel
      mime_types = %w[
        application/vnd.ms-excel
        application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
      ]

      return unless payout_records_source_excel.attached?
      return if mime_types.include?(payout_records_source_excel.content_type)

      errors.add(:payout_records_source_excel, 'muss Excel sein (.xls oder .xlsx)')
    end
  end
end
