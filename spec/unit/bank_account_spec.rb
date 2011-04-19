require 'spec_helper'

describe FreeAgent::BankAccount do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::BankAccount.collection_path.should == '/bank_accounts.xml'
    end

    it "has correct element path" do
      FreeAgent::BankAccount.element_path(:first).should == '/bank_accounts/first.xml'
      FreeAgent::BankAccount.element_path(100000).should == '/bank_accounts/100000.xml'
    end
  end


  describe ".all" do
    before(:each) do
      @bank_accounts = FreeAgent::BankAccount.all
    end

    it "returns an array" do
      @bank_accounts.should be_a(Array)
    end

    it "returns the bank accounts" do
      @bank_accounts.should have(3).records
      @bank_accounts.first.should be_a(FreeAgent::BankAccount)
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @bank_account = FreeAgent::BankAccount.find(84192)
      end

      it "returns a bank account" do
        @bank_account.should be_a(FreeAgent::BankAccount)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::BankAccount.find(1)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
