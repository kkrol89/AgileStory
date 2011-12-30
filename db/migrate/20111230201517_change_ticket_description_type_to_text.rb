class ChangeTicketDescriptionTypeToText < ActiveRecord::Migration
  def up
    change_column 'tickets', 'description', :text
  end

  def down
    change_column 'tickets', 'description', :string
  end
end
