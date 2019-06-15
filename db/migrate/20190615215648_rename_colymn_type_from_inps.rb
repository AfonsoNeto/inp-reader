class RenameColymnTypeFromInps < ActiveRecord::Migration[5.2]
  def change
    rename_column :inps, :type, :inp_object_type
  end
end
