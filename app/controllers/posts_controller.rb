class PostsController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:index,:new,:create]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    session[:post_id] = params[:id]
    m_id = Post.select(:membership_id).where(id:params[:id]).first
    @user = User.select(:name).where(id:Membership.select(:user_id).where(id:m_id['membership_id'])).first
  end

  def new
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
  end

 
  def edit
  end

 
  def create
    @membership_id = Membership.select(:id).where(user_id: current_user.id, group_id: session[:group_id]).first
    @new_post = Post.new(content: params[:post][:content],membership_id: @membership_id['id'])
    @group = Group.find_by(id: session[:group_id])
    if @new_post.save
      redirect_to group_path @group
    else
      redirect_to group_path @group
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.update_atttributes(content: params[:post][:content])
  end

  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy 
    redirect_to posts_path   
  end
end
