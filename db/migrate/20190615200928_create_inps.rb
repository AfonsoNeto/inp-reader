class CreateInps < ActiveRecord::Migration[5.2]
  def change
    create_table :inps do |t|
      t.string :type

      t.timestamps
    end
  end
end
