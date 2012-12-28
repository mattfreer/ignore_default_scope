class Customer < ActiveRecord::Base
  include Archivable
  attr_accessible :fullname, :email
  has_many :comments, :as => :author
  before_save :create_customer_no

  def create_customer_no
    self.customer_no = "cust_" << (Customer.count + 1).to_s
  end
end
