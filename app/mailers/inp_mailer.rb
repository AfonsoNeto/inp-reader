class InpMailer < ApplicationMailer
  def notify
    @upload = Upload.find(params[:upload_id])
    @result = params[:result]
    mail(to: 'test@mail.com', subject: 'Inp file processing results')
  end
end
