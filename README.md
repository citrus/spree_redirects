# Spree Redirects [![Build Status](https://secure.travis-ci.org/citrus/spree_redirects.png)](http://travis-ci.org/citrus/spree_redirects)

Spree Redirects adds an interface for redirecting old urls to new ones. It's for when you replace an existing site with a shiny new spree site and want to avoid broken links and broken hearts. 

To get a better idea of what it does, just follow the Demo instructions below...


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

Install spree_redirects by adding the following to your existing spree site's Gemfile:

```ruby
gem 'spree_redirects', '0.2.0'
```

Or if you want to track the git repo, add this instead:

```ruby
gem 'spree_redirects', :git => 'git://github.com/citrus/spree_redirects.git'
```

Now bundle up:

```bash
bundle
```
    
Then run the generator which copies the migration template into your project:

```bash
rails g spree_redirects:install
```
    
Migrate your database:

```bash
rake db:migrate
```
    
And boot up your server:

```bash  
rails s
```
 
You should now be up and running at [http://localhost:3000](http://localhost:3000)!


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

Clone this repo to where you develop, bundle up and run dummier to get the show started:

```bash
git clone git://github.com/citrus/spree_redirects.git
cd spree_redirects
bundle install
bundle exec dummier
```
  
This will generate a fresh rails app in `test/dummy`, install spree_core & spree_redirects, then migrate the test database. Sweet. 

Now just run the tests with:

```bash
bundle exec rake    
```


------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

You can easily use the test/dummy app as a demo of spree_redirects. Just `cd` to where you develop and run:
    
```bash
git clone git://github.com/citrus/spree_redirects.git
cd spree_redirects
cp test/dummy_hooks/after_migrate.rb.sample test/dummy_hooks/after_migrate.rb
bundle install
bundle exec dummier
cd test/dummy
rails s
```

Now log into the admin, click the 'Configuration' tab, then click 'Manage Redirects'. Try adding a redirect for `/shop.php` that points to `/products`, then visit [http://localhost:3000/shop.php](http://localhost:3000/shop.php). You should be redirected to `/products`.


------------------------------------------------------------------------------
Contributors
------------------------------------------------------------------------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!


------------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------------

**0.2.0 - 2012/1/5**

* Add support for spree 0.70.x and above
* Remove spork development dependency


**0.1.0 - 2011/6/1**

* Initial Release


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 - 2012 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
