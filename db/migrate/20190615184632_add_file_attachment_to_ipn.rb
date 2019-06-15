class AddFileAttachmentToIpn < ActiveRecord::Migration[5.2]
  def change
    add_attachment :ipns, :file
  end
end
