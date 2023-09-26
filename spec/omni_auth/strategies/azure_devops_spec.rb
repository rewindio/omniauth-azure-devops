# frozen_string_literal: true

describe OmniAuth::Strategies::AzureDevops do
  let(:azure_devops_strategy) { described_class.new(nil) }
  let(:request) { instance_double('Request', params: {}, scheme: 'https', url: '/auth/azure_devops/callback', env: { 'rack.input' => StringIO.new }) }

  before do
    allow(azure_devops_strategy).to receive(:request).and_return(request)
  end

  describe '#client' do
    it 'has correct Azure Devops api site' do
      expect(azure_devops_strategy.options.client_options.site).to eq('https://app.vssps.visualstudio.com/')
    end

    it 'has correct access token path' do
      expect(azure_devops_strategy.options.client_options.token_url).to eq('https://app.vssps.visualstudio.com/oauth2/token')
    end

    it 'has correct authorize url' do
      expect(azure_devops_strategy.options.client_options.authorize_url).to eq('https://app.vssps.visualstudio.com/oauth2/authorize')
    end
  end

  describe '#info' do
    let(:raw_info) { { 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' } }

    before do
      allow(azure_devops_strategy).to receive(:raw_info).and_return(raw_info)
    end

    it 'returns the correct name' do
      expect(azure_devops_strategy.info[:name]).to eq('John Doe')
    end

    it 'returns the correct email address' do
      expect(azure_devops_strategy.info[:email_address]).to eq('john.doe@example.com')
    end
  end

  describe '#extra' do
    let(:raw_info) { { 'display_name' => 'John Doe', 'email_address' => 'john.doe@example.com' } }

    before do
      allow(azure_devops_strategy).to receive(:raw_info).and_return(raw_info)
    end

    it 'includes the raw_info in extra data' do
      expect(azure_devops_strategy.extra[:raw_info]).to eq(raw_info)
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      expect(azure_devops_strategy.callback_path).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#callback_url' do
    it 'has the correct callback path' do
      expect(azure_devops_strategy.callback_url).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#token_params' do
    it 'has the correct Content-Type' do
      expect(azure_devops_strategy.token_params[:headers]['Content-Type']).to eq('application/x-www-form-urlencoded')
    end

    it 'has the correct client_assertion_type' do
      expect(azure_devops_strategy.token_params[:client_assertion_type]).to eq('urn:ietf:params:oauth:client-assertion-type:jwt-bearer')
    end

    it 'has the correct grant_type' do
      expect(azure_devops_strategy.token_params[:grant_type]).to eq('urn:ietf:params:oauth:grant-type:jwt-bearer')
    end

    it 'has the correct assertion' do
      allow(request).to receive(:params).and_return({ 'code' => 'q0398109283019283019830192830192830192830129' })
      expect(azure_devops_strategy.token_params[:assertion]).to eq('q0398109283019283019830192830192830192830129')
    end

    it 'has the correct redirect_uri' do
      expect(azure_devops_strategy.token_params[:redirect_uri]).to eq('/auth/azure_devops/callback')
    end
  end

  describe '#raw_info' do
    let(:access_token) do
      instance_double('AccessToken',
                      get: instance_double('Response',
                                           parsed: {
                                             'id' => '123',
                                             'display_name' => 'John Doe',
                                             'email_address' => 'john.doe@example.com'
                                           }))
    end

    before do
      allow(azure_devops_strategy).to receive(:access_token).and_return(access_token)
    end

    it 'fetches and parses the user profile information' do
      expect(azure_devops_strategy.raw_info['id']).to eq('123')
      expect(azure_devops_strategy.raw_info['display_name']).to eq('John Doe')
      expect(azure_devops_strategy.raw_info['email_address']).to eq('john.doe@example.com')
    end
  end
end
