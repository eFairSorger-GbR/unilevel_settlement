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

      # With which method do you access a cunsultans's sponsor?
      UnilevelSettlement.consultant_sponsor = 'sponsor'
    MULTILINE
  end
end
