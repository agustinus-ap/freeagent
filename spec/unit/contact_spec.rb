require 'spec_helper'

describe Freeagent::Contact do

  it "extends Freeagent::Base" do
    klass.superclass.should == Freeagent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      Freeagent::Contact.collection_path.should == '/contacts.xml'
    end

    it "has correct element path" do
      Freeagent::Contact.element_path(:first).should == '/contacts/first.xml'
      Freeagent::Contact.element_path(100000).should == '/contacts/1.xml'
    end
  end


  describe ".all" do
    before(:each) do
      @contacts = Freeagent::Contact.all
    end

    it "returns an array" do
      @contacts.should be_a(Array)
    end

    it "returns the contacts" do
      @contacts.should have(2).contacts
      @contacts.first.should be_a(Freeagent::Contact)
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @contact = Freeagent::Contact.find(20000)
      end

      it "returns a Contact" do
        @contact.should be_a(Freeagent::Contact)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          Freeagent::Contact.find(10000)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
