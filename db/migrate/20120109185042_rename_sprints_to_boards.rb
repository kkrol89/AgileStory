class RenameSprintsToBoards < ActiveRecord::Migration
  def up
    rename_table :sprints, :boards
  end

  def down
    rename_table :boards, :sprints
  end
end
