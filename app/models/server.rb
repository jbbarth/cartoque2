class Server < ActiveRecord::Base
  # audit for changes
  has_paper_trail
end
