json.extract! shipment, :id, :pkg_no, :created_at, :updated_at
json.url shipment_url(shipment, format: :json)
