require 'spec_helper'

describe Freeagent::Contact do

  it "extends Freeagent::Base" do
    klass.superclass.should == Freeagent::Base
  end

end
