class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page, only: %i[show]
  before_action :set_file, only: %i[index new]
  before_action :set_data, only: %i[index new ]
  before_action :set_contact, only: %i[index]
  
  
  def new
    @user_contact = current_user.contacts.build
    @contacts = Contact.all
  end

  def show
    @contacts = Contact.all
    @contacts = Contact.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def index
    @contacts = Contact.all
    @contacts = Contact.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv }
    end
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: 'contact was succesfuly created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def import
    user = current_user
    if params[:csv_file]
      #ContactsWorker.perform_async(params[:csv_file].path, user)
      Contact.import(params[:csv_file], user)
      # job_id = ContactsWorker.perform_async(params[:csv_file], user)
      # puts params[:csv_file]
      # @status = Sidekiq::Stats.new

      # puts "status:#{@status.processed}"
      # puts 'complete' if Sidekiq::Status::complete? job_id
      # puts 'queued' if Sidekiq::Status::queued? job_id
      # puts 'working' if Sidekiq::Status::working? job_id
      # puts 'retrying' if Sidekiq::Status::retrying? job_id
      # puts 'failed' if Sidekiq::Status::failed? job_id
      # puts 'interrupted' if Sidekiq::Status::interrupted? job_id

      puts "complete -- none"
      

      if $success
        redirect_to contacts_path, notice: "data was just imported to (#{$data_location}!), valid (#{$franchise}) card"
      else
        redirect_to failcontacts_path, notice: "failed data was just imported to (#{$data_location}!), valid (#{$franchise}) card"
      end
    else
      redirect_to new_contact_path, alert: 'Sorry, No file chosen, Action can not be performed'
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to failcontacts_path, alert: "#{e.message}, it seems your file has duplicated records"
    Failcontact.import_fail(params[:csv_file], user)
  rescue ActiveModel::UnknownAttributeError => e
    redirect_to new_contact_path, alert: "#{e.message}, it seems your file has invalid records"
  
  end

  private


  def set_page
    @page = params.fetch(:page, 0).to_i
  end 

  def file_params
    @data = params.permit(:csv_file)
    #@data = params.require(:fileupload).permit(:csv_file)
  end

  def set_file
    @csv_file = Fileupload.create(file_params)
    #@file = Fileupload.find_by(params[:id])
    puts '--- setfile--'
    puts @csv_file
    puts' ---*** ---'
  end

  def set_contact
    #@file = Fileupload.find_by(params[:id])
    @contact = current_user.contacts.find_by(params[:id])
  end

  def set_data
   
   #@data1 = @csv_file.csv_file.download
   puts '---data---'
   puts @data1
   puts '---***---'
  end

  def contact_params
    params.permit(
      :full_name,
      :date_of_birth,
      :phone_number,
      :address,
      :credit_card,
      :email,
      :user_id
    )
  end
end