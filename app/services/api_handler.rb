class ApiHandler
  include HTTParty
  base_uri "https://sandbox.shipmondo.com/api/public/v3"

  def initialize(username, password)
    @auth = { username: username, password: password }
  end

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
end
