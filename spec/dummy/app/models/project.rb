class Project < ActiveRecord::Base
  attr_accessible :name, :creator_id
  belongs_to :creator, :class_name => "User"
end
