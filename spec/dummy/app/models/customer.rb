class Customer < ActiveRecord::Base
  attr_accessible :fullname, :email

  before_save :create_customer_no

  def create_customer_no
    self.customer_no = "cust_" << (Customer.count + 1).to_s
  end
end
