module Authorization
  module Login
    class LoginRequired < Exception; end

    def self.included(klass)
      klass.instance_eval do
        before_filter :require_user
      end
    end

    private
    def require_user
      raise LoginRequired.new unless user_signed_in?
    end
  end
end