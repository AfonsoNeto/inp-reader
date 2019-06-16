class InpWorker
  include Sidekiq::Worker

  def perform upload_id
    upload = Upload.find(upload_id)
    result = Parser.new(upload.read_file_from_s3).get_all

    InpMailer.with(result: result, upload_id: upload_id).notify.deliver_now
  end
end
