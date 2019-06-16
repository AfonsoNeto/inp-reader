class InpMailer < ApplicationMailer
  def notify upload_id
    @upload = Upload.find_by(id: upload_id)
    mail(to: 'test@mail.com', subject: 'Inp file processing results')
  end
end
