class ResultsController < ApplicationController
  def index
    
    @order = params[:ord] == 'desc' ? 'asc' : 'desc'

    if(params[:sort_by] == 'room')
      @results = Result.by_room(params[:ord]).all
    elsif(params[:sort_by] == 'area')
      @results = Result.by_area(params[:ord]).all
    elsif(params[:sort_by] == 'check_item')
      @results = Result.by_check_item(params[:ord]).all
    elsif(params[:sort_by] == 'comment')
      @results = Result.by_comment(params[:ord]).all
    else
      @results = Result.by_severity(params[:ord]).all
    end
    
  end
  
  def new
    @checkitem = CheckItem.find_by_id(params[:check_item_id])
    @result = Result.new
    @result.check_item_id = params[:check_item_id]
  end

  def create
    if(params[:results])
      # Do something here
      logger.info "RESULTS!!!!! #{params[:results]}"
    else    
      @result = Result.new(params[:result])
      if @result.save
        redirect_to(check_list_path(@result.check_item.check_list_id), :notice => "Saved")
      else
        errormessages = ""
        @result.errors.full_messages.each do |e|
          errormessages += ", " if errormessages.length > 0 
          errormessages += e
        end
        redirect_to(check_lists_path, :notice => "Errors occurred: #{errormessages}")
      end   
  end

  def edit    
    @result = Result.find_by_id(params[:id])
  end

  def update
    @result = Result.find(params[:id])
    if @result.update_attributes(params[:result])
      redirect_to(check_list_path(@result.check_item.check_list_id), :notice => "Saved")
    else
      errormessages = ""
      @result.errors.full_messages.each do |e|
        errormessages += ", " if errormessages.length > 0
        errormessages += e
      end
      redirect_to(check_lists_path, :notice => "Errors occurred: #{errormessages}")
    end
  end
# CHECKCHECK look at destroy method - does it destroy?
  def destroy
     @result = Result.find_by_id(params[:id])
     @result.completed_on = Time.now
     @result.save
     
     redirect_to(check_list_path(@result.check_item.check_list_id), :notice => "Problem solved")
  end

  def show
  end
end

