class RemoveFileAttachmentFromIpns < ActiveRecord::Migration[5.2]
  def change
    remove_attachment :ipns, :file
  end
end
