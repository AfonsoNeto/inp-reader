class IpnsController < ApplicationController
  def new
    @ipn = Ipn.new
  end

  def show; end

  def create
    render json: { message: "success", fileId: :whatever }, status: :ok
  end

end
