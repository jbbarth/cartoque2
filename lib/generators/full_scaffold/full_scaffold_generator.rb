require 'rails/generators/rails/scaffold/scaffold_generator'

class FullScaffoldGenerator < Rails::Generators::ScaffoldGenerator
  #don't generate a scaffold.css
  remove_hook_for :stylesheet_engine

  #API stuff
  def generate_api_files
    #representers
    template "item_representer.rb", "app/representers/api/#{singular_name}_representer.rb"
    template "items_representer.rb", "app/representers/api/#{plural_name}_representer.rb"
    template "item_representer_spec.rb", "spec/representers/api/#{singular_name}_representer_spec.rb"
    template "items_representer_spec.rb", "spec/representers/api/#{plural_name}_representer_spec.rb"
    #fix controller spec
    remove_file "spec/controllers/#{plural_name}_controller_spec.rb"
    template "controller_spec.rb", "spec/controllers/#{plural_name}_controller_spec.rb"
    #api controller
    template "api_controller.rb", "app/controllers/api/#{plural_name}_controller.rb"
    template "api_controller_spec.rb", "spec/controllers/api/#{plural_name}_controller_spec.rb"
    #new route for api controller
    insert_api_route "resources :#{plural_name}"
    template "api_routing_spec.rb", "spec/routing/api/#{plural_name}_routing_spec.rb"
    #link in the api root
    in_root do
      inject_into_file 'app/controllers/api/root_controller.rb',
                       "\n        #{plural_name}: { href: api_#{plural_name}_path },",
                       { before: /\s*#hook for generators/, verbose: false }
    end
    #factories
    template "item_factory.rb", "spec/factories/#{singular_name}.rb"
    #fix view specs
    in_root do
      inject_into_file "spec/views/#{plural_name}/index.html.erb_spec.rb",
                       "\n    view.stub(:will_paginate) #avoid errors with will_paginate",
                       { after: /before\(:each\) do$/, verbose: false }
    end
    #remove "pending" directives
    gsub_file "spec/models/#{singular_name}_spec.rb", /\n\s*pending [^\n]+\n/m, "\n"
    gsub_file "spec/helpers/#{plural_name}_helper_spec.rb", /\n\s*pending [^\n]+\n/m, "\n"
    #remove integration test/unit test
    remove_file "test/"
  end

protected
  def insert_api_route(routing_code)
    log :route, routing_code
    sentinel = /\s*#hook for generators/
    in_root do
      inject_into_file 'config/routes.rb', "\n    #{routing_code}", { before: sentinel, verbose: false }
    end
  end
end
