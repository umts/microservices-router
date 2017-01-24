# microservices-router
A lightweight Rails 5 app for storing Service-Model relationships.

## API Documentation 
We use a gem to generate API docs based on specs in spec/acceptance/**_spec.rb. Add it to the gemfile:

    gem 'rspec_api_documentation'

Then bundle the gem:

    bundle install

To access the full syntax guidelines for writing specs, read the [rspec api documentation](https://github.com/zipmark/rspec_api_documentation).

Use the command below to generate the docs. Note that this command will write over the previous docs:

    rails docs:generate

Run this command to view the results:

    open doc/api/index.html
