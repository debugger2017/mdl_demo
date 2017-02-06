class PostsController < ApplicationController
 
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    session[:post_id] = params[:id]
  end

  def new
    @post = Post.new
  end

 
  def edit
  end

 
  def create
    @membership_id = Membership.select(:id).where(user_id: current_user.id, group_id: session[:group_id]).first
    @post = Post.new(content: params[:post][:content],membership_id: @membership_id['id'])
    @post.save
    redirect_to posts_path
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
