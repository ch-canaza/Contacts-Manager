class ContactsController < ApplicationController
  before_action :set_file, only: %i[index create]
  before_action :set_data, only: %i[index create]
  #require 'csv'
  #require 'open-uri'

  def index
    
    @contacts = Contact.all
    #@options = %w[papa yuca platano]
    #@csv = @csv_file.previewer
    #puts @file
    #@csv = CSV.parse(File.read("/home/chris/Downloads/employees (5).csv"), headers: true)
    #@csv = CSV.parse(File.read(file_data.to_s), headers: true)
    #@csv = @csv[0]
  end

  def create
    @csv_file.previewer

    puts '------ create ----'
    
    puts '----------** -----' 
    puts @csv_file
    puts '---------'
    redirect_to contacts_path
    #   @contact = Contact.new(contact_params)
    #   respond_to do |format|
    #   if @contact.save
    #     format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
    #   else
    #     format.html { redirect_to contacts_path, notice: 'Contact was not saved' }
    #   end
    # end

    # else
    #   redirect_to root_path
    # end
  end

  private

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

  def set_data
   #@file = Fileupload.find_by(params[:id])
   @data1 = @csv_file.csv_file.download
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
      :email
    )
  end
end