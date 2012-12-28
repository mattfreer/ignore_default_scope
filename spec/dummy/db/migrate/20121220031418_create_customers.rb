class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|

      t.string :customer_no
      t.string :email
      t.string :fullname
      t.timestamps
    end
  end
end
