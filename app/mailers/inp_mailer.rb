class InpMailer < ApplicationMailer
  def notify
    @upload = Upload.find(params[:upload_id])
    @result = JSON.parse REDIS.get(@upload.id)
    mail(to: @upload.recipient, subject: 'Inp file processing results')
  end
end
