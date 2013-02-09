require "ignore_default_scope/base"
require "active_record/base"

module IgnoreDefaultScope
end

ActiveRecord::Base.send :include, IgnoreDefaultScope::Base
