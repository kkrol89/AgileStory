module UserRoles
  def assign_member(options)
    if User::ROLES.include?(options[:role].to_sym)
      options[:project].add_member(options[:member], options[:role].to_sym)
    end
  end
end

RSpec.configure do |config|
  config.include UserRoles
end