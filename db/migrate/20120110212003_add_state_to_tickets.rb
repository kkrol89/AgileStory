class AddStateToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :state, :string, :default => 'open'
  end
end
