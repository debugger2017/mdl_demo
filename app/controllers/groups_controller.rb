class GroupsController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:index,:new,:create]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @groups = Group.joins(:memberships).where("memberships.user_id=#{current_user.id}")
  end

  def show
    session[:group_id] = params[:id]
    @posts = Membership.joins(:group).where(group_id: session[:group_id]).joins("INNER JOIN posts ON memberships.id = posts.membership_id").select("posts.id,posts.content , posts.created_at,memberships.user_id").order("posts.created_at DESC")
    @post = Post.new
    @comment = Comment.new
  end

  
  def new
    @group = Group.new

  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    #@user = current_user
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
    @member = Membership.new(user_id: current_user.id , group_id: @group.id,is_admin: true)
    @member.save
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
       params.require(:group).permit(:name)
    end
end
