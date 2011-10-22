class CreateMemberships < ActiveRecord::Migration
  def up
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :role

      t.timestamps
    end
  end

  def down
    drop_table :memberships
  end
end
