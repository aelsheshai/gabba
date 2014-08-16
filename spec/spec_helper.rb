require 'gabba'
require 'rspec'

require 'webmock/rspec'
WebMock.disable_net_connect!

def stub_analytics(expected_params)
  stub_request(
    :get,
    /ssl.google-analytics.com\/collect.*/
  ).to_return(:status => 200, :body => '', :headers => {})
end
