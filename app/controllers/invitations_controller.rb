class InvitationsController < ApplicationController
  
  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.joins("INNER JOIN users ON receiver_id = users.id").where(receiver_id: current_user.id , is_accepted: nil)
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
   
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(sender_id: current_user.id , receiver_id: params[:invite][:receiver_id] , group_id: session[:group_id])
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
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
