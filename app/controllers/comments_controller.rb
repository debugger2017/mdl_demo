class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end


  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(content: params[:comment][:content] , post_id: session[:post_id], user_id: current_user.id)
    if @comment.save
      redirect_to comments_path
    else
      redirect_to new_comment_path
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy 
    redirect_to comments_path   
  end
end
