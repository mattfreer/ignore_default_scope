class User < ActiveRecord::Base
  include Archivable
  attr_accessible :user_name, :deleted_at
  has_many :comments, :as => :author
  has_many :projects, :foreign_key => "creator_id"
  default_scope where(:deleted_at => nil)
end
