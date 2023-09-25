# frozen_string_literal: true

require 'spec_helper'

describe OmniAuth::Strategies::AzureDevops do
  subject do
    described_class.new(nil, @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) { @request }
    end
  end

  before do
    @request = double('Request')
    allow(@request).to receive_messages(params: {}, scheme: 'https', url: '/auth/azure_devops/callback')
    allow(@request).to receive(:env) { { 'rack.input' => StringIO.new } }
  end

  describe '#client' do
    it 'has correct Azure Devops api site' do
      expect(subject.options.client_options.site).to eq('https://app.vssps.visualstudio.com/')
    end

    it 'has correct access token path' do
      expect(subject.options.client_options.token_url).to eq('https://app.vssps.visualstudio.com/oauth2/token')
    end

    it 'has correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://app.vssps.visualstudio.com/oauth2/authorize')
    end
  end

  describe '#info' do
    let(:raw_info) { { 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' } }

    before do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    it 'returns the correct name' do
      expect(subject.info[:name]).to eq('John Doe')
    end

    it 'returns the correct email address' do
      expect(subject.info[:email_address]).to eq('john.doe@example.com')
    end
  end

  describe '#extra' do
    let(:raw_info) { { 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' } }

    before do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    it 'includes the raw_info in extra data' do
      expect(subject.extra[:raw_info]).to eq(raw_info)
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      expect(subject.callback_path).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#callback_url' do
    it 'has the correct callback path' do
      expect(subject.callback_url).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#token_params' do
    it 'has the correct Content-Type' do
      expect(subject.token_params[:headers]['Content-Type']).to eq('application/x-www-form-urlencoded')
    end

    it 'has the correct client_assertion_type' do
      expect(subject.token_params[:client_assertion_type]).to eq('urn:ietf:params:oauth:client-assertion-type:jwt-bearer')
    end

    it 'has the correct grant_type' do
      expect(subject.token_params[:grant_type]).to eq('urn:ietf:params:oauth:grant-type:jwt-bearer')
    end

    it 'has the correct assertion' do
      allow(@request).to receive(:params).and_return({ 'code' => 'q0398109283019283019830192830192830192830129' })
      expect(subject.token_params[:assertion]).to eq('q0398109283019283019830192830192830192830129')
    end

    it 'has the correct redirect_uri' do
      expect(subject.token_params[:redirect_uri]).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#raw_info' do
    let(:access_token) do
      instance_double(AccessToken,
                      get: instance_double(Response, parsed: { 'id' => '123', 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' }))
    end

    before do
      allow(subject).to receive(:access_token).and_return(access_token)
    end

    it 'fetches and parse user profile information' do
      expect(subject.raw_info['id']).to eq('123')
      expect(subject.raw_info['display_name']).to eq('John Doe')
      expect(subject.raw_info['email_address']).to eq('john.doe@example.com')
    end
  end
end
