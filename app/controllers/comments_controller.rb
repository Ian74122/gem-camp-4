class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update]

  def index
    @comments = @post.comments
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment created successfully'
      redirect_to post_comments_path(@post)
    else
      flash.now[:alert] = 'Comment create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment update successfully'
      redirect_to post_comments_path(@post)
    else
      flash.now[:alert] = 'Comment update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
