class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @entry_id = params[:comment][:entry_id]
    @comment = Comment.new(user_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        # format.html(redirect_to request.referer)
        @comments = Entry.find(@entry_id).comments
        format.js {render 'create.js.erb'}
      end
    else
      redirect_to root_url
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to root_url
    end
    # if @comment.destroy
    #   respond_to do |format|
    #     format.html { redirect_to  request.referer}
    #   end
    # else
    #   redirect_to root_url
    # end
  end

  private
    def user_params
      params.require(:comment).permit(:user_id,:entry_id,:content)
    end
end
