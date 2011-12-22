class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :title
      t.integer :project_id

      t.timestamps
    end
  end
end
