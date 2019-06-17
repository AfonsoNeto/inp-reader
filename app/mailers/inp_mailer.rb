class InpMailer < ApplicationMailer
  def notify
    @upload = Upload.find(params[:upload_id])
    @results = JSON.parse(REDIS.get(@upload.id))[@upload.id.to_s]
    mail(to: @upload.recipient, subject: 'Inp file processing results')
  end
end
