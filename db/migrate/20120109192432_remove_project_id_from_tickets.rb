class RemoveProjectIdFromTickets < ActiveRecord::Migration
  def up
    remove_column 'tickets', 'project_id'
  end

  def down
    add_column 'tickets', 'project_id', :integer
  end
end
