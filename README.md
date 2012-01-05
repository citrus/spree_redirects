# Spree Redirects [![Build Status](https://secure.travis-ci.org/citrus/spree_redirects.png)](http://travis-ci.org/citrus/spree_redirects)


Spree Redirects adds an interface for redirecting old urls to new ones. It's for when you replace an existing site with a shiny new spree site and want to avoid broken links and broken hearts. 

To get a better idea of what it does, just follow the Demo instructions below...


Installation
------------

Install spree_redirects by adding the following to your existing spree site's Gemfile:

    gem 'spree_redirects', '0.2.0'

Or if you want to track the git repo, add this instead:

    gem 'spree_redirects', :git => 'git://github.com/citrus/spree_redirects.git'

Now bundle up:

    bundle
    
Then run the generator which copies the migration template into your project:

    rails g spree_redirects:install
    
Migrate your database:

    rake db:migrate
    
And reboot your server:
  
    rails s
    
    
You should be up and running now!


Testing
-------

Clone this repo to where you develop, bundle up and run dummier to get the show started:

    git clone git://github.com/citrus/spree_redirects.git
    cd spree_redirects
    bundle install
    bundle exec dummier
  
This will generate a fresh rails app in `test/dummy`, install spree_core & spree_redirects, then migrate the test database. Sweet. 

Now just run the tests with:

    bundle exec rake    


Demo
----

You can easily use the test/dummy app as a demo of spree_redirects. Just `cd` to where you develop and run:
    
    git clone git://github.com/citrus/spree_redirects.git
    cd spree_redirects
    mv lib/dummy_hooks/after_migrate.rb.sample lib/dummy_hooks/after_migrate.rb
    bundle install
    bundle exec dummier
    cd test/dummy
    rails s
    

Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!


Change Log
----------

**0.2.0 - 2012/1/5**

* Add support for spree 0.70.x and above
* Remove spork development dependency


**0.1.0 - 2011/6/1**

* Initial Release


License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
