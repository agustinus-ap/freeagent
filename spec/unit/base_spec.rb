require 'spec_helper'

describe FreeAgent::Base do

  it "extends ActiveResource::Base" do
    klass.superclass.should == ActiveResource::Base
  end


  describe "DynamicFinderMatch" do

    class Record < FreeAgent::Base
    end

    before(:each) do
      @records = [
        Record.new(:username => "alpha", :email => "alpha@example.org", :locale => "en"),
        Record.new(:username => "beta", :email => "beta@example.org", :locale => "en"),
        Record.new(:username => "charlie", :email => "charlie@example.org", :locale => "jp"),
        Record.new(:username => "delta", :email => "delta@example.org", :locale => "en"),
        Record.new(:username => "beta", :email => "beta@example.org", :locale => "jp"),
      ]
      stub(Record).all { @records }
    end

    describe "#find_by_" do
      it "fetches .all records" do
        mock(Record).all { @records }
        Record.find_by_username('test')
      end

      it "searches and returns the first item matching criteria" do
        Record.find_by_locale('en').should == @records[0]
      end

      it "supports multiple criteria" do
        Record.find_by_email_and_username('beta@example.org', 'beta').should == @records[1]
        Record.find_by_username_and_email('beta', 'beta@example.org').should == @records[1]
      end
    end

    describe "#find_or_initialize_by_" do
      it "fetches .all records" do
        mock(Record).all { @records }
        Record.find_or_initialize_by_username('test')
      end

      it "searches and returns the first item matching criteria" do
        Record.find_or_initialize_by_username('en').should == @records[0]
      end

      it "supports multiple criteria" do
        Record.find_or_initialize_by_email_and_username('beta@example.org', 'beta').should == @records[1]
        Record.find_or_initialize_by_username_and_email('beta', 'beta@example.org').should == @records[1]
      end

      it "initializes the record if not available" do
        record = Record.find_or_initialize_by_email('hello@example.org', 'hello')
        record.email.should == 'hello@example.org'

        record = Record.find_or_initialize_by_username_and_email('hello', 'hello@example.org')
        record.username.should == 'hello'
        record.email.should == 'hello@example.org'
      end
    end

    describe "#find_all_by_" do
      it "fetches .all records" do
        mock(Record).all { @records }
        Record.find_all_by_username('test')
      end

      it "searches and returns all items matching criteria" do
        Record.find_all_by_locale('en').should == [@records[0], @records[1], @records[3]]
      end

      it "supports multiple criteria" do
        Record.find_all_by_email_and_username('beta@example.org', 'beta').should == [@records[1], @records[4]]
        Record.find_all_by_username_and_email('beta', 'beta@example.org').should == [@records[1], @records[4]]
      end
    end

    describe "#find_last_by_" do
      it "fetches .all records" do
        mock(Record).all { @records }
        Record.find_last_by_username('test')
      end

      it "searches and returns the last item matching criteria" do
        Record.find_last_by_locale('en').should == @records[3]
      end

      it "supports multiple criteria" do
        Record.find_last_by_email_and_username('beta@example.org', 'beta').should == @records[4]
        Record.find_last_by_username_and_email('beta', 'beta@example.org').should == @records[4]
      end
    end

    describe "#respond_to?" do
      it "responds to find_by_*" do
        Record.new.should respond_to(:find_by_name)
        Record.new.should respond_to(:find_by_name_and_email)
      end

      it "responds to find_or_initialize_by_*" do
        Record.new.should respond_to(:find_or_initialize_by_name)
        Record.new.should respond_to(:find_or_initialize_by_name_and_email)
      end

      it "responds to find_all_by_*" do
        Record.new.should respond_to(:find_all_by_name)
        Record.new.should respond_to(:find_all_by_name_and_email)
      end

      it "responds to find_last_by_*" do
        Record.new.should respond_to(:find_last_by_name)
        Record.new.should respond_to(:find_last_by_name_and_email)
      end
    end
  end

end
