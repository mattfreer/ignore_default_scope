module Archivable
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
end
