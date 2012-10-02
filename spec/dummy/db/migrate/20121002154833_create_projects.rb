class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.timestamps
      t.string :name, :limit => 50, :null => false
    end
  end
end
