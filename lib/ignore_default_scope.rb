require "ignore_default_scope/base.rb"

module IgnoreDefaultScope
end

ActiveRecord::Base.send :include, IgnoreDefaultScope::Base
