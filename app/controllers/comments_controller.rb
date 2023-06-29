class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(params.require(:comment).permit(:content))
    if @comment.save
      flash[:notice] = 'Comment created successfully'
      redirect_to post_comments_path(@post)
    else
      flash.now[:alert] = 'Comment create failed'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
