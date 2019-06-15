class DropTableIpn < ActiveRecord::Migration[5.2]
  def change
    drop_table :ipns
  end
end
