require 'spec_helper'

describe Freeagent::Base do

  it "extends ActiveResource::Base" do
    klass.superclass.should == ActiveResource::Base
  end

end
