module UnilevelSettlement
  class PayoutInvoice < ApplicationRecord
    belongs_to :run, class_name: 'UnilevelSettlement::PayoutRun', foreign_key: 'unilevel_settlement_payout_run_id',
                     optional: false, inverse_of: :invoices
    belongs_to :user, class_name: UnilevelSettlement.user_class.to_s, foreign_key: 'user_id', optional: false,
                      inverse_of: :invoices

    has_many :records, class_name: 'UnilevelSettlement::PayoutRecord', foreign_key: 'unilevel_settlement_payout_invoice_id',
                       inverse_of: :invoice

    has_one_attached :invoice_pdf

    before_validation :create_invoice_number, on: :create

    validates :invoice_number, presence: true, uniqueness: true

    def assign_invoice_totals
      totals = calculate_invoice_totals
      self.sub_total_level0 = totals[:sub_total_level0]
      self.sub_total_level1 = totals[:sub_total_level1]
      self.sub_total_level2 = totals[:sub_total_level2]
      self.sub_total = totals[:sub_total]
      self.total_vat = totals[:total_vat]
      self.total = totals[:total]
      save
    end

    def totals_ok?
      sub_totals_ok? && total_vat_ok?
    end

    def attach_invoice_pdf
      pdf_generator = UnilevelSettlement.pdf_creation_service.new(self)
      pdf_generator.send(UnilevelSettlement.pdf_creation_method)
    end

    private

    def create_invoice_number
      efairsorger = User.find_by(first_name: 'eFairSorger')
      others_count = PayoutRun.where(payout_date: run.payout_date.all_month)
                              .map { |pr| pr.invoices.where.not(user: efairsorger) }
                              .flatten
                              .count

      self.invoice_number = if user == efairsorger
                              "eFairSorger_#{run.payout_date.strftime('%Y-%m-%d')}"
                            else
                              "eFS#{run.payout_date.strftime('%y%m')}#{others_count.succ.to_s.rjust(4, '0')}"
                            end
    end

    def calculate_invoice_totals
      totals = records.pluck('SUM(amount)', 'SUM(vat)').flatten
      {
        sub_total_level0: records.for_level(0).sum(:amount),
        sub_total_level1: records.for_level(1).sum(:amount),
        sub_total_level2: records.for_level(2).sum(:amount),
        sub_total: totals.first,
        total_vat: totals.last,
        total: totals.compact.sum
      }
    end

    def sub_totals_ok?
      sub_total == (sub_total_level0 + sub_total_level1 + sub_total_level2)
    end

    def total_vat_ok?
      return true if !pays_vat? && total_vat.nil?

      vat_proportion = if UnilevelSettlement.vat_proportion.zero?
                         0
                       elsif UnilevelSettlement.vat_proportion < 1
                         UnilevelSettlement.vat_proportion
                       elsif UnilevelSettlement.vat_proportion > 1
                         UnilevelSettlement.vat_proportion.fdiv(100)
                       end

      total_vat == sub_total * vat_proportion
    end

    def pays_vat?
      pays_vat = user.send(UnilevelSettlement.vat)
      case pays_vat
      when true, 'true', 'TRUE', 1, '1' then true
      when false, 'false', 'FALSE', 0, '0' then false
      end
    end
  end
end
