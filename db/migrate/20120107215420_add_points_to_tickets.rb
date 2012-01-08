class AddPointsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :points, :integer, :default => 1
  end
end
