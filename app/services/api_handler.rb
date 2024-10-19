class ApiHandler
  include HTTParty
  base_uri "https://sandbox.shipmondo.com/api/public/v3"

  # get api_user and api_key for Basic Authentication
  def initialize(username, password)
    @auth = { username: username, password: password }
  end

  # Get balance from API
  def fetch_amount
    response = self.class.get("/account/balance", basic_auth: @auth)

    if response.success?
      parsed_response = response.parsed_response

      amount = parsed_response["amount"]
      amount
    else
      raise "API request failed with code #{response.code}: #{response.message}"
    end
  end

  # Update balance
  def update_balance(user_id)
    amount = fetch_amount

    user = Account.find(user_id)

    user.update!(balance: amount)
  end

  # create shipment (cannot create shipment due to "Parameter(s): own_agreement invalid or missing" both in rails and postman)
  def create_shipment
      body = {
        "test_mode": true,
        "own_agreement": false,
        "label_format": "a4_pdf",
        "product_code": "GLSDK_SD",
        "service_codes": "EMAIL_NT,SMS_NT",
        "reference": "Order 10001",
        "automatic_select_service_point": true,
        "sender": {
          "name": "Min Virksomhed ApS",
          "attention": "Lene Hansen",
          "address1": "Hvilehøjvej 25",
          "zipcode": "5220",
          "city": "Odense SØ",
          "country_code": "DK",
          "email": "info@minvirksomhed.dk",
          "mobile": "70400407"
        },
        "receiver": {
          "name": "Lene Hansen",
          "address1": "Skibhusvej 52",
          "zipcode": "5000",
          "city": "Odense C",
          "country_code": "DK",
          "email": "lene@email.dk",
          "mobile": "12345678"
        },
        "parcels": [
          {
            "weight": 1000
          }
        ]
      }

      options = {
        body: body.to_json,
        headers: { "Content-Type" => "application/json" },
        basic_auth: @auth
      }

      response = self.class.post("/shipments", options)

      if response.success?
        parsed_response = response.parsed_response

        # Add id and package number to local db
        Shipment.create(shipment_id: parsed_response["id"], pkg_no: parsed_response["pkg_no"])
        update_balance(1)
      else
        raise "API request failed with code #{response.code}: #{response.message}"
      end
  end
end
