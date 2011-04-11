require 'spec_helper'

describe FreeAgent::Base do

  it "extends ActiveResource::Base" do
    klass.superclass.should == ActiveResource::Base
  end

end
