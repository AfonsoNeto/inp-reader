class InpWorker
  include Sidekiq::Worker

  def perform upload_id
    # upload = Upload.find_by(id: upload_id)
    # Do the parsing...
    InpMailer.notify(upload_id).deliver_now
  end
end
