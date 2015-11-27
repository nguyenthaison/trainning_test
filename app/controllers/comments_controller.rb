class CommentsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def create
    @entry_id = params[:comment][:entry_id]
    @comment = Comment.new(user_params)
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
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private
    def user_params
      params.require(:comment).permit(:user_id,:entry_id,:content)
    end

    def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
