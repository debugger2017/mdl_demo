class CommentsController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:index,:new,:create]

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
    @comment = Comment.new(content: params[:comment][:content] , post_id: params[:comment][:post_id], user_id: current_user.id)
    @group = Group.find_by(id:session[:group_id])
    if @comment.save
      flash[:success] = "Your comment is saved."
      redirect_to group_path @group
    else
      flash[:danger] = "Your comment is not saved."
      redirect_to group_path @group
    end
  end

  def update
  end

  def destroy   
  end
end
