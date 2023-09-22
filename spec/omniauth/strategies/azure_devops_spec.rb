require 'spec_helper'

describe OmniAuth::Strategies::AzureDevops do
  before :each do
    @request = double('Request')
    allow(@request).to receive(:params) { {} }
    allow(@request).to receive(:scheme) { 'https' }
    allow(@request).to receive(:url) { '/auth/azure_devops/callback' }
    allow(@request).to receive(:env) { { 'rack.input' => StringIO.new } }
  end

  subject do
    OmniAuth::Strategies::AzureDevops.new(nil, @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) { @request }
    end
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

    it 'should return the correct name' do
      expect(subject.info[:name]).to eq('John Doe')
    end

    it 'should return the correct email address' do
      expect(subject.info[:email_address]).to eq('john.doe@example.com')
    end
  end

  describe '#extra' do
    let(:raw_info) { { 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' } }

    before do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    it 'should include the raw_info in extra data' do
      expect(subject.extra[:raw_info]).to eq(raw_info)
    end
  end

  describe '#callback_path' do
    it 'should have the correct callback path' do
      expect(subject.callback_path).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#callback_url' do
    it 'should have the correct callback path' do
      expect(subject.callback_url).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#token_params' do
    it 'should have the correct Content-Type' do
      expect(subject.token_params[:headers]['Content-Type']).to eq('application/x-www-form-urlencoded')
    end

    it 'should have the correct client_assertion_type' do
      expect(subject.token_params[:client_assertion_type]).to eq('urn:ietf:params:oauth:client-assertion-type:jwt-bearer')
    end

    it 'should have the correct grant_type' do
      expect(subject.token_params[:grant_type]).to eq('urn:ietf:params:oauth:grant-type:jwt-bearer')
    end

    it 'should have the correct assertion' do
      allow(@request).to receive(:params) { { 'code' => 'q0398109283019283019830192830192830192830129' } }
      expect(subject.token_params[:assertion]).to eq('q0398109283019283019830192830192830192830129')
    end

    it 'should have the correct redirect_uri' do
      expect(subject.token_params[:redirect_uri]).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#raw_info' do
    let(:access_token) { instance_double('AccessToken', get: instance_double('Response', parsed: { 'id' => '123', 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' })) }

    before do
      allow(subject).to receive(:access_token).and_return(access_token)
    end

    it 'should fetch and parse user profile information' do
      expect(subject.raw_info['id']).to eq('123')
      expect(subject.raw_info['display_name']).to eq('John Doe')
      expect(subject.raw_info['email_address']).to eq('john.doe@example.com')
    end
  end
end
