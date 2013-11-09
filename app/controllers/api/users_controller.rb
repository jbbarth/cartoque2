class API::UsersController < API::ApplicationController
  # GET /api/users
  def index
    respond_with User.page(params[:page]).per_page(items_per_page)
  end

  # GET /api/users/1
  def show
    respond_with User.find(params[:id])
  end

  # POST /api/users
  def create
    user = User.new(user_params)
    if user.save
      respond_with user
    else
      render_error json: { message: "Validation Failed", errors: user.errors }
    end
  end

  # PATCH/PUT /api/users/1
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      respond_with user
    else
      render_error json: { message: "Validation Failed", errors: user.errors }
    end
  end

  # DELETE /api/users/1
  def destroy
    respond_with User.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
