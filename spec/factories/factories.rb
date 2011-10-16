Factory.sequence :email do |n|

end

Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.org" }
  u.password 'secret'
  u.password_confirmation 'secret'
  u.after_build do |user|
    user.confirm!
  end
end

Factory.define :project do |p|
  p.sequence(:name) { |n| "Project #{n}" }
  p.description 'Example project description'
  p.association(:user)
end

