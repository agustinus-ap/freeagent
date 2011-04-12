require 'spec_helper'

describe FreeAgent::Attachment do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::Attachment.collection_path.should == '/attachments.xml'
    end

    it "has correct element path" do
      FreeAgent::Attachment.element_path(:first).should == '/attachments/first.xml'
      FreeAgent::Attachment.element_path(100000).should == '/attachments/100000.xml'
    end
  end


  describe ".all" do
    before(:each) do
      @attachments = FreeAgent::Attachment.all
    end

    it "returns an array" do
      @attachments.should be_a(Array)
    end

    it "returns the attachments" do
      @attachments.should have(2).records
      @attachments.first.should be_a(FreeAgent::Attachment)
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @attachment = FreeAgent::Attachment.find(2)
      end

      it "returns an attachment" do
        @attachment.should be_a(FreeAgent::Attachment)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::Attachment.find(1)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
