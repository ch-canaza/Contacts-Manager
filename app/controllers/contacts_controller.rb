class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page, only: %i[show]
  before_action :set_file, only: %i[index new import create]
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
    
  end

  def map_headers
    
  end

  def import
    user = current_user.id
    generated_file = "#{Rails.root}/public/generated_data.csv"
    a = ImportContactsWorker.perform_async(generated_file, user)
    redirect_to contacts_path, notice: "data was just imported"
    puts "---***---"
    puts a
    puts " working well"
    puts "---***---"

  #   user = current_user
  #   generated_file = '/home/chris/reto_koombea/importador_de_contactos2/public/generated_data.csv'
  #   #if params[:csv_file]
  #   Contact.import(generated_file, user)

  #     if $success
  #       redirect_to contacts_path, notice: "data was just imported to (#{$data_location}!), valid (#{$franchise}) card"
  #     else
  #       Failcontact.import_fail(params[:csv_file], user)
  #       redirect_to failcontacts_path, notice: "failed data was just imported to (#{$data_location}!), valid (#{$franchise}) card"
  #     end
  #   #else
  #     #redirect_to new_contact_path, alert: 'Sorry, No file chosen, Action can not be performed'
  #   #end
  # rescue ActiveRecord::RecordInvalid => e
    
  #   Failcontact.import(params[:csv_file], user)
  #   puts 'imported'
    
  #   redirect_to failcontacts_path, alert: "#{e.message}, it seems your file has duplicated records"
    
  # rescue ActiveModel::UnknownAttributeError => e
  #   redirect_to new_contact_path, alert: "#{e.message}, it seems your file has invalid records"
  # end
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
    puts '--- setfile--'
    puts @csv_file
    puts' ---*** ---'
  end

  def set_contact
    @contact = current_user.contacts.find_by(params[:id])
  end

  def set_data
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
      :user_id,
      
    )
  end
end