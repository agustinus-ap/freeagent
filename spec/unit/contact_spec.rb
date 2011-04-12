require 'spec_helper'

describe FreeAgent::Contact do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::Contact.collection_path.should == '/contacts.xml'
    end

    it "has correct element path" do
      FreeAgent::Contact.element_path(:first).should == '/contacts/first.xml'
      FreeAgent::Contact.element_path(100000).should == '/contacts/100000.xml'
    end
  end


  describe ".all" do
    before(:each) do
      @contacts = FreeAgent::Contact.all
    end

    it "returns an array" do
      @contacts.should be_a(Array)
    end

    it "returns the contacts" do
      @contacts.should have(2).records
      @contacts.first.should be_a(FreeAgent::Contact)
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @contacts = FreeAgent::Contact.find(2)
      end

      it "returns a contact" do
        @contacts.should be_a(FreeAgent::Contact)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::Contact.find(1)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
