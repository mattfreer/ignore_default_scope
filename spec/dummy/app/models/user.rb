class User < ActiveRecord::Base
   attr_accessible :user_name, :deleted_at
   default_scope where(:deleted_at => nil)

   has_many :projects, :foreign_key => "creator_id"

   #archive
   # ------------------------------------------
   def archived=(b)
     if ActiveRecord::ConnectionAdapters::Column.value_to_boolean(b)
       update_attribute(:deleted_at, Time.now)
     else
       update_attribute(:deleted_at, nil)
     end
   end

   def archived
     deleted_at.present?
   end
   # ------------------------------------------
end
