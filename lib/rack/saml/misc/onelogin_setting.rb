module Rack
  class Saml
    module OneloginSetting
      require 'ruby-saml'

      def saml_settings
        settings = OneLogin::RubySaml::Settings.new
        settings.assertion_consumer_service_url = @config['assertion_consumer_service_uri']
        settings.issuer = config_val('saml_sp')
        if ENV['SP_CERT']
          settings.certificate = ENV['SP_CERT']
        elsif @config['sp_cert']
          settings.certificate = IO::File.open(@config['sp_cert'], 'r').read
        end
        if ENV['SP_KEY']
          settings.private_key = ENV['SP_KEY']
        elsif @config['sp_key']
          settings.private_key = IO::File.open(@config['sp_key'], 'r').read
        end
        settings.idp_sso_target_url = @metadata['saml2_http_redirect']
        settings.idp_cert = @metadata['certificate']
        settings.name_identifier_format = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
        settings.private_key = config_val('sp_key_path') && ::File.read(@config['sp_key_path'])
        #settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
        settings
      end

      def config_val(key)
        @config[key].respond_to?(:call) ? @config[key].call(request) : @config[key]
      end
    end
  end
end
