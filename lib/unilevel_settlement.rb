require "unilevel_settlement/engine"

module UnilevelSettlement
  mattr_accessor :user_class
  mattr_accessor :consultant_number
  mattr_accessor :consultant_full_name
  mattr_accessor :consultant_sponsor
  mattr_accessor :vat
  mattr_accessor :vat_proportion

  # -- pdf generation
  mattr_accessor :should_create_invoice_pdf
  mattr_accessor :pdf_creation_service
  mattr_accessor :pdf_creation_method

  # -- csv_generation
  mattr_accessor :should_export_csv
  mattr_accessor :csv_generation_service
  mattr_accessor :csv_generation_method

  # class name from app set by initializer via lib/generators/unilevel_settlement.rb
  def self.user_class
    @@user_class.constantize
  end

  def self.consultant_number
    @@consultant_number
  end

  def self.consultant_sponsor
    @@consultant_sponsor
  end

  def self.consultant_full_name
    @@consultant_full_name
  end

  def self.vat
    @@vat
  end

  def self.vat_proportion
    @@vat_proportion
  end

  # -- pdf generation --

  def self.should_create_invoice_pdf
    @@should_create_invoice_pdf
  end

  def self.pdf_creation_service
    @@pdf_creation_service.is_a?(String) ? @@pdf_creation_service.constanize : @@pdf_creation_service
  end

  def self.pdf_creation_method
    @@pdf_creation_method
  end

  # -- csv generation --

  def self.should_export_csv
    @@should_export_csv
  end

  def self.csv_generation_service
    @@csv_generation_service.is_a?(String) ? @@csv_generation_service.constanize : @@csv_generation_service
  end

  def self.csv_generation_method
    @@csv_generation_method
  end
end
