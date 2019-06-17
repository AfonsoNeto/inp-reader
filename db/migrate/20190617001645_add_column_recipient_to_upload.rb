class AddColumnRecipientToUpload < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :recipient, :string, default: 'to@example.com'
  end
end
