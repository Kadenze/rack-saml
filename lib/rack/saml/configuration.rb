module Rack
  class Saml
    class Configuration

      attr_accessor :protected_path
      attr_accessor :metadata_path
      attr_accessor :assertion_handler
      attr_accessor :saml_idp
      attr_accessor :saml_sess_timeout
      attr_accessor :shib_app_id
      attr_accessor :shibb_ds
      attr_accessor :allowed_clock_drift
      attr_accessor :validation_error
      attr_accessor :saml_sp
      attr_accessor :sp_cert
      attr_accessor :sp_key_path
      # set default values

      def initialize
        @saml_sess_timeout = 1800
        @allowed_clock_drift = 60
        @protected_path = '/auth/shibboleth/callback'
        @metadata_path = '/Shibboleth.sso/Metadata'
        @assertion_handler = 'onelogin'
        @saml_idp = 'https://localhost/idp/shibboleth'
        @shib_app_id = 'default'
        @shibb_ds = 'https://localhost/discovery/WAYF'
        @validation_error = true
      end

      def to_h
        hash = {}
        self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
        hash
      end
    end
  end
end
