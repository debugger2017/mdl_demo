class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    @post = Post.select(:content).where(id:@comment.post_id).first
    @user = User.select(:name).where(id:@comment.user_id).first
  end


  def new
    @comment = Comment.new
    @comments = Comment.all.order(created_at: :desc)
  end

  def edit
  end

  def create
    @comment = Comment.new(content: params[:comment][:content] , post_id: session[:post_id], user_id: current_user.id)
    if @comment.save
      flash[:success] = "Your comment is saved."
      redirect_to comments_path
    else
      flash[:danger] = "Your comment is not saved."
      redirect_to new_comment_path
    end
  end

  def update
  end

  def destroy   
  end
end
