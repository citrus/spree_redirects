Spree Redirects
===============

Spree Redirects adds an interface for redirecting old urls to new ones. It's for when you replace an existing site with a shiny new spree site and want to avoid broken links and broken hearts. 

To get a better idea of what it does, just follow the Demo instructions below...


Installation
------------

Install spree_redirects by adding the following to your existing spree site's Gemfile:

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


### If you'd like to use Spork
    
Boot the drb server with:
    
    bundle exec spork
        
In another window, run all tests:

    testdrb test/**/*_test.rb
    
Or just a specific test:

    testdrb test/unit/redirect_test.rb


### No Spork

If you don't want to spork, just use rake:

    rake

    


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


License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.