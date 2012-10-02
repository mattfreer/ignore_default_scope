class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.timestamps
      t.datetime :deleted_at
      t.string :user_name, :limit => 50
    end

    add_index :users, :deleted_at
  end
end
