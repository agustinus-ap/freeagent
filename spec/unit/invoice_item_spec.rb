require 'spec_helper'

describe FreeAgent::InvoiceItem do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::InvoiceItem.collection_path(:invoice_id => 1).should == '/invoices/1/invoice_items.xml'
    end

    it "has correct element path" do
      FreeAgent::InvoiceItem.element_path(:first, :invoice_id => 1).should == '/invoices/1/invoice_items/first.xml'
      FreeAgent::InvoiceItem.element_path(100000, :invoice_id => 1).should == '/invoices/1/invoice_items/100000.xml'
    end
  end


  context "when the invoice exists" do
    describe ".all" do
      before(:each) do
        @invoice_items = FreeAgent::InvoiceItem.all(:params => { :invoice_id => 2 })
      end

      it "returns an array" do
        @invoice_items.should be_a(Array)
      end

      it "returns the invoice items" do
        @invoice_items.should have(1).records
        @invoice_items.first.should be_a(FreeAgent::InvoiceItem)
      end
    end

    describe ".find(id)" do
      context "when the record exists" do
        before(:each) do
          @invoice_item = FreeAgent::InvoiceItem.find(2, :params => { :invoice_id => 2 })
        end

        it "returns an invoice" do
          @invoice_item.should be_a(FreeAgent::InvoiceItem)
        end
      end

      context "when the record does not exist" do
        it "raises a ResourceNotFound error" do
          lambda do
            FreeAgent::InvoiceItem.find(1, :params => { :invoice_id => 2 })
          end.should raise_error(ActiveResource::ResourceNotFound)
        end
      end
    end
  end

  context "when the invoice does not exist" do
    describe ".all" do
      it "raises a ResourceNotFound error" do
        pending 'ActiveResource returns nil'
        lambda do
          FreeAgent::InvoiceItem.all(:params => { :invoice_id => 1 })
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end

    describe ".find(id)" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::InvoiceItem.find(1, :params => { :invoice_id => 1 })
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
