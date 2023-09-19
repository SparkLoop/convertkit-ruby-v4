require "spec_helper"

describe ConvertkitV4 do
  it 'has a version number' do
    expect(ConvertkitV4::VERSION).not_to be nil
  end

  describe "#configure" do
    before do
      @old_configuration = ConvertkitV4.configuration.dup
    end

    after do
      ConvertkitV4.configuration = @old_configuration
    end

    it "sets the api_secret value" do
      ConvertkitV4.configure do |config|
        config.api_secret = "new_secret"
      end

      expect(ConvertkitV4.configuration.api_secret).to eql("new_secret")
    end

    it "sets the api_key value" do
      ConvertkitV4.configure do |config|
        config.api_key = "new_key"
      end

      expect(ConvertkitV4.configuration.api_key).to eql("new_key")
    end

    it "sets the timeout value" do
      ConvertkitV4.configure do |config|
        config.timeout = 10
      end

      expect(ConvertkitV4.configuration.timeout).to eql(10)
    end

    it "sets the open_timeout value" do
      ConvertkitV4.configure do |config|
        config.open_timeout = 10
      end

      expect(ConvertkitV4.configuration.open_timeout).to eql(10)
    end
  end
end
