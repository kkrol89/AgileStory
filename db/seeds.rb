# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'

Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

module Seeds
  class Projects
    def initialize(user)
      @user = user
    end

    def populate
      build_projects(:user => @user, amount: 5, role: User::ROLES[:admin])
      build_projects(:user => @user, amount: 5, role: User::ROLES[:developer])
      build_projects(:user => @user, amount: 5, role: User::ROLES[:visitor])

      build_memberships(amount: 5, role: User::ROLES[:developer])
      build_memberships(amount: 5, role: User::ROLES[:visitor])
    end

    private
    def build_projects(options)
      options[:amount].to_i.times do
        project = Factory(:project, :name => Faker::Internet.domain_word.capitalize)
        project.users.last.update_attribute(:email, Faker::Internet.free_email)
        project.add_member(options[:user], options[:role])
      end
    end

    def build_memberships(options)
      Project.find_each do |project|
        options[:amount].to_i.times do
          project.add_member(Factory(:user, :email => Faker::Internet.free_email), options[:role])
        end
      end
    end
  end
end

Seeds::Projects.new(Factory(:user, email: "konrad.krol@ragnarson.com", password: "s3cr3t", password_confirmation: "s3cr3t")).populate