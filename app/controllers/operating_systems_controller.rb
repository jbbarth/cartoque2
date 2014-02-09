class OperatingSystemsController < ApplicationController
  before_action :set_operating_system, only: [:show, :edit, :update, :destroy]
  before_action :build_possible_operating_systems_tree, only: [:edit, :update]

  # GET /operating_systems
  def index
    @operating_systems = OperatingSystem.arrange_as_array(order: 'name')
  end

  # GET /operating_systems/1
  def show
  end

  # GET /operating_systems/new
  def new
    @operating_system = OperatingSystem.new
    build_possible_operating_systems_tree
  end

  # GET /operating_systems/1/edit
  def edit
  end

  # POST /operating_systems
  def create
    @operating_system = OperatingSystem.new(operating_system_params)
    build_possible_operating_systems_tree

    if @operating_system.save
      redirect_to @operating_system, notice: 'Operating system was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /operating_systems/1
  def update
    if @operating_system.update(operating_system_params)
      redirect_to @operating_system, notice: 'Operating system was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /operating_systems/1
  def destroy
    @operating_system.destroy
    redirect_to operating_systems_url, notice: 'Operating system was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operating_system
      @operating_system = OperatingSystem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def operating_system_params
      params.require(:operating_system).permit(:name, :codename, :supported_until, :parent_id)
    end

    #see: https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
    def build_possible_operating_systems_tree
      @operating_systems = OperatingSystem.arrange_as_array({order: 'name'}, @operating_system.possible_parents)
    end
end
