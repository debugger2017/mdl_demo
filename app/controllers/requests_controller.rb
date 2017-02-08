class RequestsController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:request_respond,:index,:request_respond]
  def index
    @requests = Request.joins("INNER JOIN memberships ON requests.group_id = memberships.group_id").select(:id,:group_id,:sender_id).where("memberships.is_admin=true AND memberships.user_id = #{current_user.id} AND requests.is_granted IS NULL")
  end

  
  def show
  end

  def new
    @requests = Group.select(:id,:name).where.not(id:Group.select(:id).where(id:Membership.select(:group_id).where(user_id:current_user.id)))
  end

  def edit
  end

  
  def create
    @request = Request.new(sender_id: current_user.id , group_id: params[:request][:group_id])
    @request.save
    redirect_to new_request_path
  end

  def update
  end

  def destroy
  end

  def request_respond
    message = params[:commit]
    request = Request.find_by(id: params[:request_respond][:request_id])
    if message == "Yes"
      request.update_attributes(is_granted: true)
      membership = Membership.new(user_id: params[:request_respond][:sender_id] , group_id: params[:request_respond][:group_id] , is_admin: false)
      membership.save
    else
      request.update_attributes(is_granted: false)
    end
  end
end
