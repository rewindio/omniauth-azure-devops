# frozen_string_literal: true

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class AzureDevops < OmniAuth::Strategies::OAuth2
      option :name, :azure_devops

      option :client_options, {
        site: 'https://app.vssps.visualstudio.com/',
        authorize_url: 'https://app.vssps.visualstudio.com/oauth2/authorize',
        token_url: 'https://app.vssps.visualstudio.com/oauth2/token'
      }

      option :authorize_params, {
        request_type: 'Assertion'
      }

      uid { raw_info['id'] }

      info do
        {
          name: raw_info['display_name'],
          email_address: raw_info['email_address']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/_apis/profile/profiles/me').parsed
      end

      def token_params
        super.tap do |params|
          params[:headers] = { 'Content-Type': 'application/x-www-form-urlencoded' }
          params[:client_assertion_type] = 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer'
          params[:client_assertion] = client.secret
          params[:grant_type] = 'urn:ietf:params:oauth:grant-type:jwt-bearer'
          params[:assertion] = request.params['code']
          params[:redirect_uri] = callback_url
        end
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
