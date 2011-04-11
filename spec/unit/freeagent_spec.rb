require 'spec_helper'

describe Freeagent do

  before(:each) do
    Freeagent::Base.tap do |base|
      base.site = base.user = base.password = nil
    end
  end

  describe ".configured?" do
    it "returns true when Base.user, Base.password, Base.site are configured" do
      klass.configured?.should be_false

      klass.username  = "email@example.com"
      klass.configured?.should be_false

      klass.password  = "letmein"
      klass.configured?.should be_false

      klass.subdomain = "example"
      klass.configured?.should be_true
    end
  end

  describe ".configure" do
    context "without block" do
      it "raises LocalJumpError" do
        lambda do
          klass.configure
        end.should raise_error(LocalJumpError)
      end
    end

    context "with block" do
      it "yields self" do
        klass.configure do |config|
          config.should be(klass)
        end
      end

      it "implements the configuration pattern" do
        klass.configured?.should be_false
        klass.configure do |config|
          config.username   = "email@example.com"
          config.password   = "letmein"
          config.subdomain  = "example"
        end
        klass.configured?.should be_true
      end
    end
  end

end
