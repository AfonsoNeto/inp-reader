class InpWorker
  include Sidekiq::Worker

  def perform upload_id
    upload = Upload.find(upload_id)
    parser = Parser.new(file: upload.read_file_from_s3, upload_id: upload_id)
    parser.parse_while_storing_on_redis!

    InpMailer.with(upload_id: upload_id).notify.deliver_now
  end
end
