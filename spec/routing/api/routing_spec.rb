require "spec_helper"

describe API::ApplicationController do
  it 'routes non-existent URLs to a 404' do
    params = ['api/application#render_404', { a: 'non-existent', format: 'json' } ]
    get('/api/non-existent').should    route_to(*params)
    post('/api/non-existent').should   route_to(*params)
    put('/api/non-existent').should    route_to(*params)
    delete('/api/non-existent').should route_to(*params)
  end
end
