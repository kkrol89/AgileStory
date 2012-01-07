class AddPointScaleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :point_scale, :string, :default => 'fibonacci'
  end
end
