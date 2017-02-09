class PostsController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:index,:new,:create]
  before_action :correct_user , only: [:show,:edit,:destroy]

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

  private 

  def correct_user
      post = Post.find_by(id:params[:id])
      group = Membership.select(:group_id).where(id:post[:membership_id]).first
      member = Membership.find_by(user_id:current_user.id , group_id: group['group_id'])
      if member.nil?
          flash[:danger] = "You are not member of this group,please join"
          redirect_to new_request_path
      end
  end
end
