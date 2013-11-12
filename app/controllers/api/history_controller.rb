class API::HistoryController < API::ApplicationController
  rescue_from NameError do
    render json: { message: "Resource type not found" }, status: :not_found
  end

  def index
    item_type = params[:item_type].camelize.constantize
    item = item_type.find(params[:item_id])
    versions = item.versions.reorder(created_at: :desc).page(params[:page])
    respond_with History.new(versions, item)
  end
end
