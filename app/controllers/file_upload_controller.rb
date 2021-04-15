class FileUploadController < ApplicationController
  before_action :set_data, only: %i[index create]
  before_action :authenticate_user!

  def new
    @contacts = Contact.all
    if params[:csv_file]
      CSV.foreach(params[:csv_file], headers: true) do |row|
        @headers = row.headers
        flash[:notice] = 'now match columns'
        redirect_to fileupload_index_path
      end
    end
  end

  def index
    @contacts = Contact.all
    if params[:csv_file]
      CSV.foreach(params[:csv_file], headers: true) do |row|
        @headers = row.headers
        redirect_to new_fileupload_path
      end
    end
  end

  def show; end

  def create; end

  private

  def file_params
    @data = params.permit(:csv_file)
  end

  def set_file
    @csv_file = Fileupload.create(file_params)
  end

  def set_data
    if @csv_file
      @csv_file.csv_file.download
    end
  end
end