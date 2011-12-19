class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string :goal
      t.datetime :start_date
      t.integer :duration
      t.integer :project_id
      t.integer :number
      t.timestamps
    end
  end
end
