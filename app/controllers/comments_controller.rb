# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    # if @comment.save
    #  flash[:notice] = 'Comment was saved successfully.'
    #  redirect_to @post
    # else
    #  flash[:danger] = @post.errors.full_messages
    #  render :new, status: :unprocessable_entity
    # end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :parent_id)
  end
end
