Sample API scripts
==================

This directory contains some sample scripts which demonstrate how to use the
REST API (and maybe later some integration scripts with other tools).


Ruby scripts
------------

Ruby scripts in this directory may use some gems to ease the integration with
Cartoque's API. A Gemfile is provided to automatically install needed gems with
bundler:

  cd extra/sample_api/ruby/
  bundle install

Then you have to provide some environment variables that are used in the
scripts so that it knows the URL where to reach your Cartoque instance,
and the token used for authentication:

  export CARTOQUE_URL=http://localhost:3000/
  export CARTOQUE_TOKEN=blah

  bundle exec ./list_servers.rb

If you want to run scripts from the root of the repo, you may have a problem
because the correct Gemfile sits in the `extra/sample_api/ruby/` directory. But
you can precise it through the command-line:

  BUNDLE_GEMFILE=extra/sample_api/ruby/Gemfile bundle exec extra/sample_api/ruby/list_servers.rb

