class InvitationsController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:index,:new,:respond]
  def index
    @invitations = Invitation.joins("INNER JOIN users ON receiver_id = users.id").where(receiver_id: current_user.id , is_accepted: nil)
  end

  def show
  end
  
  def new   
    @invites = User.select(:id,:name).where.not(id:Membership.select(:user_id).where(group_id:session[:group_id]))
  end

  def edit
  end

  def create
    @invitation = Invitation.new(sender_id: current_user.id , receiver_id: params[:invite][:receiver_id] , group_id: session[:group_id])
    if @invitation.save
      flash[:success] = "Invitation sent successfully"
    else
      flash[:danger] = "Invitation not sent."
    end
  end

  def update
  end

  def destroy
  end

  def respond
    msg = params[:commit]
    invitation = Invitation.find_by(id: params[:invite][:id])
    invitation.update_attributes(is_accepted: true)
    if msg == "Yes"
      membership = Membership.new(user_id: current_user.id , group_id: params[:invite][:group_id] , is_admin: false)
      membership.save
    end
  end
end
