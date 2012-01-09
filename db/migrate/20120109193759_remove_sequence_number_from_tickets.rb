class RemoveSequenceNumberFromTickets < ActiveRecord::Migration
  def up
    remove_column 'tickets', 'sequence_number'
  end

  def down
    add_column 'tickets', 'sequence_number', :integer
  end
end
