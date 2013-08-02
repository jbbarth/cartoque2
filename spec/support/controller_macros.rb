#see: https://github.com/plataformatec/devise/wiki/How-To:-Controllers-tests-with-Rails-3-(and-rspec)
module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = User.first || User.create!(email: 'contact@example.net', password: 'test1234')
      sign_in @user
    end
  end
end
