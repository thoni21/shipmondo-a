class CreateShipments < ActiveRecord::Migration[7.2]
  def change
    create_table :shipments do |t|
      t.integer :shipment_id
      t.string :pkg_no

      t.timestamps
    end
  end
end
