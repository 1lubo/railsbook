# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_like, only: [:destroy]
  before_action :find_post

  def already_liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end

  def create
    if already_liked?
      flash[:notice] = 'You cannot like more than one time'
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    if !already_liked?
      flash[:notice] = 'You cannot unlike this'
    else
      @like.destroy
    end
    redirect_to post_path(@post), status: 303
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = find_post.likes.find(params[:id])
  end
end
