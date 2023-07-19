class PostsController < ApplicationController
  require 'csv'
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:categories, :user, :genre).page(params[:page])
    respond_to do |format|
      format.html
      format.xml { render xml: @posts.as_json }
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << %w[email id title content categories created_at]

          @posts.each do |p|
            csv << [
              p.user&.email, p.id, p.title, p.content,
              p.categories.pluck(:name).join(','), p.created_at
            ]
          end
        end
        render plain: csv_string
      }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if Rails.env.development?
      @post.ip_address = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    else
      @post.ip_address = request.remote_ip
    end
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    authorize @post, :edit?, policy_class: PostPolicy
    authorize @post, :in_one_week?, policy_class: PostPolicy
  end

  def update
    authorize @post, :update?, policy_class: PostPolicy
    authorize @post, :in_one_week?, policy_class: PostPolicy
    if @post.update(post_params)
      flash[:notice] = 'Post update successfully'
      redirect_to posts_path(page: params[:page])
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post, :destroy?, policy_class: PostPolicy

    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :genre_id, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
