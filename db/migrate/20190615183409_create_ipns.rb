class CreateIpns < ActiveRecord::Migration[5.2]
  def change
    create_table :ipns do |t|
      t.string :type

      t.timestamps
    end
  end
end
