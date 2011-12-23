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
  m.role User::ROLES[:admin]
end

Factory.define :project do |p|
  p.sequence(:name) { |n| "Project #{n}" }
  p.description 'Example description'
  p.after_build { |project| project.memberships << Factory.build(:membership, :project => project, :role => User::ROLES[:admin]) }
end

Factory.define :sprint do |s|
  s.goal "Example goal"
  s.start_date 2.days.from_now
  s.duration 14
  s.association(:project)
end

Factory.define :ticket do |t|
  t.title "Friends invite feature"
  t.description "Example ticket description"
  t.association(:project)
end

Factory.define :chat do |c|
  c.title "DevChat"
  c.association(:project)
end

Factory.define :message do |m|
  m.content "Hello!"
  m.association(:user)
  m.association(:chat)
end