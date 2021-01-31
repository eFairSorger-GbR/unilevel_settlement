require "unilevel_settlement/engine"

module UnilevelSettlement
  mattr_accessor :user_class
  mattr_accessor :consultant_number

  # class name from app set by initializer via lib/generators/unilevel_settlement.rb
  def self.user_class
    @@user_class.constantize
  end

  def self.consultant_number
    @@consultant_number
  end
end
