class Upload < ApplicationRecord
  has_attached_file :file

  validates_attachment :file, presence: true,
    content_type: { content_type: 'text/plain' },
    extension: 'ipn'
end