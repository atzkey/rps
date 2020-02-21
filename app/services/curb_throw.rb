#require 'faraday_middleware'

class CurbThrow
  def call
    response = @curb_client.get('throw')

    # Getting rid of the weird double quotes
    JSON.parse(response.body)['body'].tr('"', '')
  end

  def initialize
    retry_options = {
      max: 5,
      interval: 0.5,
      interval_randomness: 0.5,
      backoff_factor: 2,
      exceptions: [
        Faraday::ConnectionFailed,
        Faraday::RetriableResponse
      ],
      methods: [],
      retry_statuses: [200, 500],
      retry_if: lambda do |env, exception|
        return true unless env.response_body.present?

        response = JSON.parse(env.response_body)
        response['statusCode'] != 200
      end
    }
    @curb_client = Faraday.new(Rails.configuration.curb_api) do |f|
      f.response :logger
      f.request :instrumentation
      f.request :retry, retry_options
    end
  end
end