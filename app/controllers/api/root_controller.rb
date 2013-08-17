class API::RootController < API::ApplicationController
  # GET /api/
  def index
    render json: {
      _links: {
        #self url
        self:     { href: api_root_path },
        #resources
        apps:     { href: api_apps_path },
        contacts: { href: api_contacts_path },
        servers:  { href: api_servers_path },
      }
    }
  end
end
