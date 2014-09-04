class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :bounce_if_logged_out
  
  # GET /comments/new
  def new
    @comment = Comment.new(tour_stop: TourStop.find(params[:tour_stop_id]))
  end

  # GET /comments/1/edit
  def edit
    unless @comment.commenter == @current_user || @current_user.admin?
      redirect_to root_url, notice: 'This is not your comment.'
    end
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.commenter = @current_user
    
    return bounce_if_uninvited unless @current_user.invited_to? @comment.tour
         
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.tour, notice: 'Comment successfully posted!' }
      else
        format.html { render :new }
      end
    end
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                

  # PATCH/PUT /comments/1
  def update
    unless @comment.commenter == @current_user || @current_user.admin?
      redirect_to root_url, notice: 'This is not your comment. Step away.'
      return
    end
    
    respond_to do |format|
      if @comment.update(comment_update_params)
        format.html { redirect_to @comment.tour, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    unless @comment.commenter == @current_user || @current_user.admin?
      redirect_to root_url, notice: 'This is not your comment. Step away.'
      return
    end
    
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @comment.tour, notice: "Comment successfully deleted." }
    end
  end
  
  private
  
    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:tour_stop_id, :text)
    end
    
    def comment_update_params
      params.require(:comment).permit(:text)
    end
end
