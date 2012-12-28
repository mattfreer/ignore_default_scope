class Project < ActiveRecord::Base
  attr_accessible :name
  belongs_to :creator, :class_name => "User"
end
