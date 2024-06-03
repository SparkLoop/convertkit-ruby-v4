require "convertkit_v4/version"
require "convertkit_v4/configuration"
require "convertkit_v4/client"

module ConvertkitV4
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
