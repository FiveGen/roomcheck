class PhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
    result_id = params[:id]

    if(result_id.to_i > 0)
      result = Result.find(params[:id])
      result.image = params[:image]
      result.save
    elsif(result_id == "new" && params[:check_item_id])
      result = Result.new(check_item_id: params[:check_item_id], severity: 1, comment: "", image: params[:image])
      result_id = result.id if result.save
    end

    render :text => result_id

  end
  
  def show
    logger.info "!!!!!!!\nPhotosController#show called!!!! params = #{params.inspect}, request.fullpath = #{request.fullpath}\n!!!!!!!"
  end
end
