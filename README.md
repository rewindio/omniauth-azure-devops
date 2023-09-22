# OmniAuth Azure DevOps Strategy

OmniAuth Azure DevOps is a Ruby gem that provides authentication for your Ruby applications via the Azure DevOps OAuth 2.0 authentication system.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-azure-devops'
```

And then execute:

```bash
bundle install
```

## Usage

1. Register your application with Azure DevOps to obtain the `AZURE_DEVOPS_CLIENT_ID` and `AZURE_DEVOPS_CLIENT_SECRET` credentials.

2. In your application configuration, add the following line to use the Azure DevOps OmniAuth strategy:

   ```ruby
   provider :azure_devops, ENV['AZURE_DEVOPS_CLIENT_ID'], ENV['AZURE_DEVOPS_CLIENT_SECRET'], scope: 'vso.auditlog etc...', callback_path: '/link/azure_devops/oauth_callback'
   ```

   Replace `ENV['AZURE_DEVOPS_CLIENT_ID']` and `ENV['AZURE_DEVOPS_CLIENT_SECRET']` with your Azure DevOps client credentials.

3. Implement the necessary routes and views to initiate the authentication process and handle the callback.

4. When users access the authentication route, they will be redirected to Azure DevOps for authentication. After successful authentication, Azure DevOps will redirect them back to your specified callback URL.

5. Access user information and tokens as needed in your application by utilizing the OmniAuth authentication data.

## Running Tests

You can run the test suite using the following command:

```bash
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/rewindio/omniauth-azure-devops](https://github.com/rewindio/omniauth-azure-devops). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org) code of conduct.

## License

This gem is available as open-source software under the [MIT License](https://opensource.org/licenses/MIT).
