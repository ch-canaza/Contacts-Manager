class FileUploadController < ApplicationController
  before_action :set_data, only: %i[index create new]
  before_action :set_file, only: %i[ create ]
 
  before_action :authenticate_user!

  def new
    @file = current_user.fileuploads.new(file_params)
    @original_headers = Fileupload.header_previewer(@csv_file)
    puts "original_headers #{@original_headers}"
  end

  def index

  end

  def show
    @file = current_user.fileuploads.find_by(params[:id])
  
  end

  def create
    # @file = current_user.fileuploads.new(file_params)
    # csv_path = rails_blob_path(@file.csv_file, disposition: 'attachment')
    # puts "csv_pàth: #{csv_path}"
    # CSV.parse(csv_path, headers: true) do |row|
    #   "------*****----------"
    #   puts "content: #{row}"
    #   "--------**-----------"
    # end
    @headers = params[:file]
    file = "#{Rails.root}/public/generated_data.csv"
    CSV.open(file, 'w', write_headers: true, headers: @headers) do |writer|
      CSV.foreach(params[:csv_file], headers: true) do |row|
        
        writer << row 
      end
    end
    redirect_to new_file_upload_path, notice: "data accepted, you can now click on impot it"
  end

  private

  
  def file_params
    params.permit(:csv_file)
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