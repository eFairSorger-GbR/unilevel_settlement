module UnilevelSettlement
  module ApplicationHelper
    def method_missing method, *args, &block
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          main_app.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

    def respond_to?(method)
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          true
        else
          super
        end
      else
        super
      end
    end

    def payout_record_hint(contract)
      reason = []
      reason << 'Storno' if contract.cancellation?
      reason << 'Folgeprovision' if contract.follow_up?

      reason.any? ? " (#{reason.join('/')})" : nil
    end
  end
end
