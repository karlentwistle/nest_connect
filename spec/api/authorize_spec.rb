require 'spec_helper'

RSpec.describe NestConnect::API::Authorize do
  let(:auth_code) { 'auth_code' }
  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:stdout) { StringIO.new }

  subject(:authorize) do
    NestConnect::API::Authorize.new(
      auth_code: auth_code,
      client_id: client_id,
      client_secret: client_secret,
      stdout: stdout
    )
  end

  describe '#run' do
    it 'writes access_token to configuration when status code is 200' do
      stub_request_success

      authorize.run

      expect(global_config.access_token).to eql("foo")
    end

    it 'outputs the response body when status code isnt 200' do
      stub_request_failed

      authorize.run

      stdout.rewind
      expect(stdout.gets).to eql({"error_description" => "authorization code not found"}.to_s)
    end
  end

  def stub_request_success
    stub_request(:post, "https://api.home.nest.com/oauth2/access_token").
      with(
        body: {
          'client_id' => 'client_id',
          'client_secret' => 'client_secret',
          'code' => 'auth_code',
          'grant_type' => 'authorization_code'
        },
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded',
        }).
      to_return(
        status: 200,
        body: {"access_token": "foo"}.to_json,
        headers: {
          'Content-Type' => 'application/json',
        }
      )
  end

  def stub_request_failed
    stub_request(:post, "https://api.home.nest.com/oauth2/access_token").
      with(
        body: {
          'client_id' => 'client_id',
          'client_secret' => 'client_secret',
          'code' => 'auth_code',
          'grant_type' => 'authorization_code'
        },
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded',
        }).
      to_return(
        status: 400,
        body: {"error_description"=>"authorization code not found"}.to_json,
        headers: {
          'Content-Type' => 'application/json',
        }
      )
  end
end
