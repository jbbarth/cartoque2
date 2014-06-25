# generate random seed for rspec
# see: https://github.com/jonleighton/spring/issues/113
Spring.after_fork do
  if Rails.env == 'test'
    RSpec.configure do |config|
      srand
      config.seed = srand % 0xFFFF
    end
  end
end
