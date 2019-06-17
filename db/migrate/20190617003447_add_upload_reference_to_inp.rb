class AddUploadReferenceToInp < ActiveRecord::Migration[5.2]
  def change
    add_reference :inps, :upload, foreign_key: true
  end
end
