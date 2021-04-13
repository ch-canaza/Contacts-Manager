class FileUploadController < ApplicationController
  #before_action :set_file, only: %i[index create]
  before_action :set_data, only: %i[index create]
 

  def index
    @file = Fileupload.find_by(params[:id])
    @files = Fileupload.all
  end

  def show
    @file = Fileupload.find_by(params[id])
  end

  # def create
  #   #@csv_file.previewer
  #   redirect_to root_path
   
  # end

  private

  def file_params
    @data = params.permit(:csv_file)
    #params.require(:fileupload).permit(:csv_file)
  end

  def set_file
    @csv_file = Fileupload.create(file_params)
  end

  def set_data
    if @csv_file
      @csv_file.csv_file.download
    end
    #puts @data
  end
end