class AddTypeToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :type, :string, :default => 'Sprint'
  end
end
