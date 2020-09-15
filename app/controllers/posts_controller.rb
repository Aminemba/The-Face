class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  # before_action :authenticate_user
  before_action :logged_in?

  def index
      @post = Post.new
      @posts = current_user.friends_and_own_posts
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = 'post created!'
        redirect_to authenticated_root_path

      else
        flash[:danger] = 'Try again!'
        redirect_to authenticated_root_path
      end
    end


  def show
  end

  def new
    @post = current_user.Post.new
  end

  def edit
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
  @post = current_user.posts.find_by(id: params[:id])
  @post.destroy
  flash[:success] = 'Post deleted'
  redirect_to current_user
  end


  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_post
    @post = current_user.Post.find(user_params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
