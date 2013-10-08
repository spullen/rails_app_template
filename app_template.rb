# change README to markdown
remove_file 'README.rdoc'
create_file 'README.md', 'TODO'

# generate root controller
if yes? 'Do you want to generate a root controller?'
  name = ask('What should it be called?').underscore
  generate :controller, "#{name} index"
  route "root to: '#{name}\#index'"
end
 
# set up additional application folders
keep_file 'app/services'
keep_file 'app/presenters'
keep_file 'app/forms'
 
# Set up gems
gem 'jquery-ui-rails'
gem 'haml'
gem 'will_paginate'
gem 'has_scope'
gem 'carrierwave'
gem 'cocoon'
gem 'cancan'
gem 'american_date'
 
# test and development gems
gem_group :test, :development do
  gem 'debugger'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'timecop'
end
    
# simple_form configuration
simple_form_bootstrap = false
if install_simple_form  = yes?('Install Simple Form?')
  gem 'simple_form'
  simple_form_bootstrap = yes?('Use bootstrap configuration for simple form?')
end
 
# devise confirguration
devise_model_name = 'User'
if install_devise = yes?('Install Devise?')
  gem 'devise'
  if no?('Create default devise User model?')
    devise_model_name = ask('Devise model name?')
  end
end
 
# run the bundle command
run 'bundle install'
 
# install rspec
generate 'rspec:install'
keep_file 'spec/acceptance'
 
# install simple form
if install_simple_form
  simple_form_command = 'simple_form:install'
  simple_form_command += ' --bootstrap' if simple_form_bootstrap
  generate simple_form_command
end
 
# install devise
if install_devise
  generate 'devise:install'
  generate 'devise', devise_model_name
end
 
# create the ruby version and gemset files
run 'rvm list'
rvm_ruby_version = ask('Ruby Version?')

run 'rvm gemset list'
rvm_ruby_gemset = ask('Ruby Gemset?')

create_file '.ruby-version', rvm_ruby_version
create_file '.ruby-gemset', rvm_ruby_gemset
 
# git initialization
git :init
append_file '.gitignore', 'config/database.yml'
append_file '.gitignore', 'public/uploads'
run 'cp config/database.yml config/database.yml.example'
git add: '.', commit: '-m "initial commit"'