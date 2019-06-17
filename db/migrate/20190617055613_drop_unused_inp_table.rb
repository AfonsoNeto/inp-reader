class DropUnusedInpTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :inps
  end

  def down
  end
end
