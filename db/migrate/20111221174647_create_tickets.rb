class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :description
      t.integer :project_id

      t.timestamps
    end
  end
end
