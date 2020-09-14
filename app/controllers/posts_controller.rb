class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :logged_in?

  def index
    @posts = current_user.posts.all
  end

  def show
  end

  def new
    @post = current_user.Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    @post.id = post_params[:id]
    render :new if @post.invalid?
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_post
    @post = current_user.Post.find(user_params[:id])
  end

  def post_params
    params.require(:post).permit(:posts, :id, :image, :image_cache, :user_id)
  end
end
