# frozen_string_literal: true

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
      flash[:success] = 'Post was edited successfully.'
    else
      flash[:danger] = @post.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
    # if @post.save
    #  redirect_to @post
    #  flash[:success] = 'New post created successfully.'
    # else
    #  flash[:danger] = @post.errors.full_messages
    #  render :new, status: :unprocessable_entity
    # end
  end

  def show
    @post = Post.find(params[:id])
    @pre_like = @post.likes.find { |like| like.user_id == current_user.id }
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:success] = 'Post deleted successfully'
    redirect_to root_path, status: :see_other
  end

  def index
    @posts = Post.where(user_id: [current_user.friends.ids]).or(Post.where(user_id: [current_user.id])).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body)
  end
end
