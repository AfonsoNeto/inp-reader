class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      render json: { message: "success", fileId: :whatever }, status: :ok
    else
      render json: { error: @upload.errors.full_messages.join(',')}, status: :unprocessable_entity
    end
  end

  private

    def upload_params
      params.require(:upload).permit(:file)
    end
end
