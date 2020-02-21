require 'test_helper'
require 'ostruct'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should retry for a successful Curb's throw" do
    WebMock.reset!
    stubbed_request = stub_request(:any, /throw/).
      to_timeout.then.
      to_return(
        status: 200,
        body: '{"statusCode":500,"body":"Something went wrong. Please try again later."}',
        headers: {"Content-Type"=> "application/json"}
      ).then.
      to_return(
        status: 200,
        body: '{"errorMessage":"2020-02-20T11:20:00.401Z 48755825-eee4-4ad3-8974-3f82b29d1da3 Task timed out after 3.00 seconds"}',
        headers: {"Content-Type"=> "application/json"}
      ).then.
      to_return(
        status: 500,
        body: nil,
        headers: {"Content-Type"=> "application/json"}
      ).
      to_return(
        status: 200,
        body: '{"statusCode":200,"body":"\"scissors\""}',
        headers: {"Content-Type"=> "application/json"}
      )

    post game_url, params: {throw: 'rock'}

    assert_requested(stubbed_request, times: 5)
    assert_match 'win', @response.body
  end

  test "should use game rules defined in Rails.configuration" do
    Rails.stubs(:configuration).returns(OpenStruct.new(rps_rules: {
      'hammer' => ['rock'],
      'rock' => []
    }))
    CurbThrow.any_instance.stubs(:call).returns('hammer')

    post game_url, params: {throw: 'rock'}

    assert_match 'loss', @response.body
  end
end
