module UnilevelSettlement::DelegateAttributes
  extend ActiveSupport::Concern

  module ClassMethods
    def delegate_if_not_set(*methods, to:)
      methods.each do |method|
        define_method method do
          if !new_record? && self[method].nil? && !send(to).send(method).blank?
            send(to).send(method)
          else
            self[method]
          end
        end
      end
    end
  end
end

# USAGE
# https://forum.upcase.com/t/activerecord-possible-to-delegate-nil-values-to-parent-model-that-behaves-like-a-template/4189/3
# class Package < ActiveRecord::Base
#   extend NilDelegatable
#
#   delegate_if_nil :description, :sku, to: :product
# end
