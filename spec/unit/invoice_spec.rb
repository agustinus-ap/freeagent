require 'spec_helper'

describe FreeAgent::Invoice do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::Invoice.collection_path.should == '/invoices.xml'
    end

    it "has correct element path" do
      FreeAgent::Invoice.element_path(:first).should == '/invoices/first.xml'
      FreeAgent::Invoice.element_path(100000).should == '/invoices/100000.xml'
    end
  end


  describe ".all" do
    before(:each) do
      @attachments = FreeAgent::Invoice.all
    end

    it "returns an array" do
      @attachments.should be_a(Array)
    end

    it "returns the contacts" do
      @attachments.should have(2).contacts
      @attachments.first.should be_a(FreeAgent::Invoice)
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @attachment = FreeAgent::Invoice.find(2)
      end

      it "returns a Contact" do
        @attachment.should be_a(FreeAgent::Invoice)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::Invoice.find(1)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
