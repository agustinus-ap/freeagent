require 'active_resource'
require 'freeagent/version'
require 'freeagent/base'

module Freeagent

  BASE_URI = "https://%s.freeagent.com"

  autoload :Contact,    'freeagent/contact'


  class << self

    # Checks if the client is properly configured.
    #
    # @return [Boolean]
    def configured?
      Base.user && Base.password && Base.site
    end

    # Sets the client configuration.
    #
    # @return [void]
    #
    # @yield  [self]
    #
    # @example
    #   Freeagent.configure do |config|
    #     config.username   = "email@example.com"
    #     config.password   = "letmein"
    #     config.subdomain  = "example"
    #   end
    #
    def configure
      if block_given?
        yield self
      else
        raise LocalJumpError, "Required configuration block"
        # TODO: allow users to pass configuration using an environment variable
      end
    end


    def username=(value)
      Base.user = value
    end

    def password=(value)
      Base.password = value
    end

    def subdomain=(value)
      Base.site = value.blank? ? nil : (BASE_URI % value)
    end
    
  end

end
