module Authorization
  def should_require_login_for(*actions)
    actions.each do |action|
      action.call
      response.should redirect_to(new_user_session_path)
    end
  end

  def should_not_authorize_for(*actions)
    actions.each do |action|
      action.call
      response.response_code.should == 401
    end
  end
end

RSpec.configure do |config|
  config.include Authorization, :type => :controller
end