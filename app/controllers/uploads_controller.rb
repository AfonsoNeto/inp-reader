class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :update]

  def new
    @upload = Upload.new
  end

  def show
    respond_to do |format|
      format.html { @records = @upload.records }
    end
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      render json: { message: "success", fileId: @upload.id }, status: :ok
    else
      render json: { error: @upload.errors.full_messages.join(',')}, status: :unprocessable_entity
    end
  end

  def update

    if @upload.update(upload_params)
      InpWorker.perform_async(@upload.id)
      render json: { message: "success", fileId: @upload.id }, status: :ok
    else
      render json: { error: @upload.errors.full_messages.join(',')}, status: :unprocessable_entity
    end
  end

  private

    def set_upload
      @upload = Upload.find(params[:id])
    end

    def upload_params
      params.require(:upload).permit(:recipient, :file)
    end
end
