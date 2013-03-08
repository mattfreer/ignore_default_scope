class Comment < ActiveRecord::Base
  attr_accessible :author_id, :author_type
  belongs_to :author, :polymorphic => true
end
