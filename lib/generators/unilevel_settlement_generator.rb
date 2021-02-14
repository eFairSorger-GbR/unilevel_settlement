class UnilevelSettlementGenerator < Rails::Generators::Base
  desc "Description: Create the customizable config file for UnilevelSettlement"

  def create_initializer_file
    create_file "config/initializers/unilevel_settlement.rb", content
  end

  def content
    <<~MULTILINE
      # This file can be used to adapt the unilevel_settlement gem to your app!

      # Set the class from your app that will receive the settlement (e.g. User, Consultant, Agent)
      UnilevelSettlement.user_class = 'User'

      # Set the offical consultant number of the user (might not be the id)
      UnilevelSettlement.consultant_number = 'consultant_number'

      # Method on consultant to retrieve full name. This will be within the settlement invoice.
      UnilevelSettlement.consultant_full_name = 'full_name'

      # With which method do you access a cunsultans's sponsor?
      UnilevelSettlement.consultant_sponsor = 'sponsor'

      # Which method on your settlement receiver class (e.g. User) will tell if the settlement needs to apply a VAT (needs to be a boolean)?
      # If it is always true or false, just write `true` or `false` respectively
      UnilevelSettlement.vat = 'vat_liability'

      # How high is VAT in percent (0 - 100)?
      UnilevelSettlement.vat_proportion = 19

      # Do you want to create invoice pdfs during payout_invoice_generation?
      # If so, you need to create a service that does create it and attach it to the invoice.
      # For the initialization, you will be handed the invoice, and only the invoice, as an argument.
      # After initialization/instantiation we will call the attaching/generation method on the instatinized service (only one method).
      # You can attach the pdf to the invoice model through the active storage relation `has_one_attached :invoice_pdf` we put on invoice.
      # That`s it! You do not need to return anything.
      UnilevelSettlement.should_create_invoice_pdf = true
      UnilevelSettlement.pdf_creation_service = InvoicePdfCreator
      UnilevelSettlement.pdf_creation_method = 'attach_invoice_pdf'
    MULTILINE
  end
end
