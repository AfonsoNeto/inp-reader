class Upload < ApplicationRecord
  has_attached_file :file, s3_protocol: 'https'

  validates_attachment :file, presence: true,
    content_type: { content_type: 'text/plain' },
    extension: 'inp'
end
