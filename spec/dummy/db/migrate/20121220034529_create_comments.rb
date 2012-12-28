class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.references :author, :polymorphic => true
      t.timestamps
    end
    add_index :comments, [:author_type, :author_id]
  end
end
