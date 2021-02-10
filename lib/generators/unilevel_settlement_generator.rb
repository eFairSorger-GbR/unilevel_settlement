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
    MULTILINE
  end
end
