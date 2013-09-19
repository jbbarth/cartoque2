require 'rails/generators/rails/scaffold/scaffold_generator'

class FullScaffoldGenerator < Rails::Generators::ScaffoldGenerator
  #don't generate a scaffold.css
  remove_hook_for :stylesheet_engine
end
