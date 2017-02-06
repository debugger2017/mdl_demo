class RequestsController < ApplicationController
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.joins("INNER JOIN memberships ON requests.group_id = memberships.group_id").select(:id,:group_id,:sender_id).where("memberships.is_admin=true AND memberships.user_id = #{current_user.id} AND requests.is_granted IS NULL")
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @requests = Group.joins(:memberships).joins("INNER JOIN users ON memberships.user_id=users.id AND users.id != #{current_user.id}").select(:id,:name).distinct
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(sender_id: current_user.id , group_id: params[:request][:group_id])
    @request.save
    redirect_to new_request_path
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
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
