require "unilevel_settlement/engine"

module UnilevelSettlement
  mattr_accessor :user_class

  # class name from app set by initializer via lib/generators/unilevel_settlement.rb
  def self.user_class
    @@user_class.constantize
  end
end
