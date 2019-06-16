class Upload < ApplicationRecord
  has_attached_file :file, s3_protocol: 'https'

  validates_attachment :file, presence: true,
    content_type: { content_type: 'text/plain' },
    extension: 'inp'

  def read_file_from_s3
    resp = init_s3.get_object(
      bucket: Rails.application.credentials[:aws][Rails.env.to_sym][:bucket_name],
      key: "uploads/files/#{self.id}/#{self.file_file_name}"
    )

    resp.body.string.split("\n")
  end


    def init_s3
      local_credentials = Rails.application.credentials[:aws]

      Aws::S3::Client.new({
        region: 'us-east-1',
        credentials: Aws::Credentials.new(local_credentials[:access_key_id], local_credentials[:secret_access_key])
      })
    end
end
