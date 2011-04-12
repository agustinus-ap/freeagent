require 'spec_helper'

describe FreeAgent::Bill do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::Bill.collection_path.should == '/bills.xml'
    end

    it "has correct element path" do
      FreeAgent::Bill.element_path(:first).should == '/bills/first.xml'
      FreeAgent::Bill.element_path(100000).should == '/bills/100000.xml'
    end
  end


  describe ".all" do
    context "without period parameter" do
      it "raises a BadRequest error" do
        lambda do
          FreeAgent::Bill.all
        end.should raise_error(ActiveResource::BadRequest)
      end
    end

    context "with period parameter" do
      before(:each) do
        @bills = FreeAgent::Bill.all(:params => { :period => '2011-01-01_2011-12-31' })
      end

      it "returns an array" do
        @bills.should be_a(Array)
      end

      it "returns the bills" do
        @bills.should have(2).records
        @bills.first.should be_a(FreeAgent::Bill)
      end
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @bill = FreeAgent::Bill.find(2)
      end

      it "returns a bill" do
        @bill.should be_a(FreeAgent::Bill)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::Bill.find(1)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
