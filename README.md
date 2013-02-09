# IgnoreDefaultScope

A Ruby on Rails plug-in that provides a mechanism for *ActiveRecord* Models to ignore the *default_scope* of a *belongs_to* association.

## Installation

In your **Gemfile**

``` ruby
gem 'ignore_default_scope', :git => 'git://github.com/mattfreer/ignore_default_scope.git'
```

## Usage

You can instruct an *ActiveRecord* Model to ignore the *default_scope* of a *belongs_to* association like this:

``` ruby
class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  ignore_default_scope :creator
end

class User < ActiveRecord::Base
  has_many :projects, :foreign_key => "creator_id"
  default_scope where(:deleted_at => nil)
end
```

In the above mock scenario *Projects* are created by *Users*, who can be archived (soft-deleted). In general archived *Users* are not relevant, hence a *default_scope* is applied to *Users* which filters out archived records. However *Projects* and their *creators* need to be readable regardless of whether the *creator* is archived. The solution being to instruct *Project* to *ignore_default_scope* of its *creator*.

## Supports polymorphic associations

Ignoring the *default_scope* of Polymorphic *belongs_to* relations works to, as demonstrated in following example:

``` ruby

class Comment < ActiveRecord::Base
  belongs_to :author, :polymorphic => true
  ignore_default_scope :author
end

class User < ActiveRecord::Base
  has_many :comments, :as => :author
  default_scope where(:deleted_at => nil)
end

class Customer < ActiveRecord::Base
  has_many :comments, :as => :author
  default_scope where(:deleted_at => nil)
end
```

In the above mock scenario *Comments* can be created by *Users* or *Customers*. Both *Users* and *Customers* can be archived. *Comments* and their *authors* need to be readable regardless of whether the *author* is archived.

# Support

This gem supports Rails 3.1.1 and above.

Copyright © 2013 Matt Freer, released under the MIT license
