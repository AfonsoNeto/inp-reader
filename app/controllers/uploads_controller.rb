class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    render json: { message: "success", fileId: :whatever }, status: :ok
  end
end
