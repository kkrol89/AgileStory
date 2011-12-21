class AddSequenceNumberToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :sequence_number, :integer
  end
end
