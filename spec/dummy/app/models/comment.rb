class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :author, :polymorphic => true
end
