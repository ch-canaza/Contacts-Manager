class FileUploadController < ApplicationController
  before_action :set_file, only: %i[index create]
  before_action :set_data, only: %i[index create]
 

  def index
    @file = Fileupload.find_by(params[:id])
    #@datas = @data
    #puts @datas 
  end

  def show
    @file = Fileupload.find_by(params[id])
  end

  def create
  #   #@file = Fileupload.new(file_params)
  #   #if @file.save
  #     #@data = @file.csv_file.download
  #     #puts @data
  #     #redirect_to root_path
  #     #previewer

  #     redirect_to file_upload_index_path(@file)
  #   else
  #     redirect_to root_path
  # #    redirect_to file_upload_index_path

  #   end
  end

  private

  def file_params
    @data = params.permit(:csv_file)
    #params.require(:fileupload).permit(:csv_file)
  end

  def set_file
    #@file = Fileupload.create(file_params)
  end

  def set_data
    @file.csv_file.download
    
    #puts @data
  end
end