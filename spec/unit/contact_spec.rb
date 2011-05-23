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


  describe "validations" do
    it "requires either name or organisation_name" do
      c = klass.new
      c.should_not be_valid
      c.errors[:first_name].should_not be_nil
      c.errors[:last_name].should_not be_nil
      c.errors[:organisation_name].should_not be_nil

      c = klass.new(:last_name => "Carletti")
      c.should_not be_valid
      c.errors[:first_name].should_not be_nil

      c = klass.new(:first_name => "Simone")
      c.should_not be_valid
      c.errors[:last_name].should_not be_nil
    end

    it "is valid with name" do
      c = klass.new(:first_name => "Simone", :last_name => "Carletti")
      c.should be_valid
    end

    it "is valid with organisation_name" do
      c = klass.new(:organisation_name => "Company")
      c.should be_valid
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
        @contacts = FreeAgent::Contact.find(447693)
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


  describe "#name" do
    it "returns nil when no first_name and last_name" do
      klass.new.name.should be_nil
    end

    it "returns the first_name when first_name" do
      klass.new(:last_name => "Carletti").
          name.should == "Carletti"
    end

    it "returns the first_name when first_name" do
      klass.new(:first_name => "Simone").
          name.should == "Simone"
    end

    it "returns first_name and last name" do
      klass.new(:first_name => "Simone", :last_name => "Carletti").
          name.should == "Simone Carletti"
    end
  end

  describe "#invoices" do
    it "merges the finder options" do
      mock(FreeAgent::Invoice).all(:from => '/contacts/0/invoices.xml')
      FreeAgent::Contact.new(:id => 0).invoices

      mock(FreeAgent::Invoice).all(:from => '/contacts/0/invoices.xml', :params => { :foo => 'bar' })
      FreeAgent::Contact.new(:id => 0).invoices(:params => { :foo => 'bar' })
    end

    context "when the contact exists" do
      before(:each) do
        @invoices = FreeAgent::Contact.new(:id => 469012).invoices
      end

      it "returns an array" do
        @invoices.should be_a(Array)
      end

      it "returns the invoices" do
        @invoices.should have(2).records
        @invoices.first.should be_a(FreeAgent::Invoice)
        @invoices.first.id.should == 2715138
      end
    end

    context "when the contact does not exist" do
      it "raises a ResourceNotFound error" do
        pending 'ActiveResource rescues the error and returns nil'
        lambda do
          FreeAgent::Contact.new(:id => 1).invoices
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
