class AddBoardIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :board_id, :integer
  end
end
