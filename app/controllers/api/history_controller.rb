class API::HistoryController < API::ApplicationController
  rescue_from NameError do
    message = "Resource type not found."
    message << " Missing 'item_type' parameter." if params[:item_type].blank?
    message << " Missing 'item_id' parameter." if params[:item_id].blank?
    render json: { message: message }, status: :not_found
  end

  def index
    item_type = params[:item_type].camelize.constantize
    item = item_type.find(params[:item_id])
    versions = item.versions.reorder(created_at: :desc).page(params[:page])
    respond_with History.new(versions, item)
  end
end
