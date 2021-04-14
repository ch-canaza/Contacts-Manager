class FailcontactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_failed_contact, only: :show

  def index  
    @failed_contacts = current_user.failcontacts.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def show; end

  private 

  def set_failed_contact
    @failed_contact = current_user.failcontacts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "You can only view your own failed contacts"
    redirect_to failcontacts_path
  end

end
