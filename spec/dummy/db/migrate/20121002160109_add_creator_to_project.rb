class AddCreatorToProject < ActiveRecord::Migration
  def change
    add_column :projects, :creator_id, :integer
  end
end
