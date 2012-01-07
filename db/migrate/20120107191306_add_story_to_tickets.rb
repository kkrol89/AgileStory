class AddStoryToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :story, :string, :default => 'feature'
  end
end
