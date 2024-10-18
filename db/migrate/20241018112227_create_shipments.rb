class CreateShipments < ActiveRecord::Migration[7.2]
  def change
    create_table :shipments do |t|
      t.string :pkg_no

      t.timestamps
    end
  end
end
