class StaticPagesController < ApplicationController
  
  before_action :redirect , only: [:home]

  def home
  end

  def help
  end

  def about
  end

  def practice
  end

  private

  def redirect
  	if !current_user.nil?
  		redirect_to current_user
  	end
  	
  end
end
