require 'spec_helper'

describe 'Main routing' do
  it 'has a welcome#index route' do
    get('welcome/index').should route_to('welcome#index')
  end

  it 'owns root of the app' do
    get('/').should route_to('welcome#index')
  end

  it 'routes non-existent URLs to a 404' do
    get('/non-existent').should     route_to('application#render_404', a: 'non-existent')
    post('/non-existent').should    route_to('application#render_404', a: 'non-existent')
    put('/non-existent').should     route_to('application#render_404', a: 'non-existent')
    delete('/non-existent').should  route_to('application#render_404', a: 'non-existent')
  end
end
