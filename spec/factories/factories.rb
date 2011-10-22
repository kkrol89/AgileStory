Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.org" }
  u.password 'secret'
  u.password_confirmation 'secret'
  u.after_build do |user|
    user.confirm!
  end
end

Factory.define :membership do |m|
  m.association(:project)
  m.association(:user)
  m.role Role::ROLES[:admin]
end

Factory.define :project do |p|
  p.sequence(:name) { |n| "Project #{n}" }
  p.description 'Example description'
  p.after_build { |project| project.memberships << Factory(:membership, :project => project, :role => Role::ROLES[:admin]) }  
end

