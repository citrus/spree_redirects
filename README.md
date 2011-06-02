Spree Redirects
===============

Spree Redirects adds an interface for redirecting old urls to new ones. 


[todo] write more


Installation
------------

Here's how you'll install spree_redirects into your existing spree site:


Add the following to your Gemfile:

    gem 'spree_redirects', :git => 'git://github.com/citrus/spree_redirects.git'

Make your bundle happy:

    bundle install
    
Now run the generator:

    rails g spree_redirects:install
    
Then migrate your database:

    rake db:migrate
    
And reboot your server:
  
    rails s
    
    
You should be up and running now!


Testing
-------

Clone this repo to where you develop, bundle up, then run `dummier' to get the show started:

    git clone git://github.com/citrus/spree_redirects.git
    cd spree_redirects
    bundle install
    bundle exec dummier
    


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