require 'spec_helper'

describe FreeAgent::Project do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::Project.collection_path.should == '/projects.xml'
    end

    it "has correct element path" do
      FreeAgent::Project.element_path(:first).should == '/projects/first.xml'
      FreeAgent::Project.element_path(100000).should == '/projects/100000.xml'
    end
  end


  describe ".all" do
    before(:each) do
      @projects = FreeAgent::Project.all
    end

    it "returns an array" do
      @projects.should be_a(Array)
    end

    it "returns the projects" do
      @projects.should have(1).records
      @projects.first.should be_a(FreeAgent::Project)
    end
  end

  describe ".find(id)" do
    context "when the record exists" do
      before(:each) do
        @project = FreeAgent::Project.find(2)
      end

      it "returns a project" do
        @project.should be_a(FreeAgent::Project)
      end
    end

    context "when the record does not exist" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::Project.find(1)
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

  describe "#invoices" do
    it "merges the finder options" do
      mock(FreeAgent::Invoice).all(:from => '/projects/0/invoices.xml')
      FreeAgent::Project.new(:id => 0).invoices

      mock(FreeAgent::Invoice).all(:from => '/projects/0/invoices.xml', :params => { :foo => 'bar' })
      FreeAgent::Project.new(:id => 0).invoices(:params => { :foo => 'bar' })
    end

    context "when the project exists" do
      before(:each) do
        @invoices = FreeAgent::Project.new(:id => 2).invoices
      end

      it "returns an array" do
        @invoices.should be_a(Array)
      end

      it "returns the invoices" do
        @invoices.should have(1).records
        @invoices.first.should be_a(FreeAgent::Invoice)
      end
    end

    context "when the project does not exist" do
      it "raises a ResourceNotFound error" do
        pending 'ActiveResource rescues the error and returns nil'
        lambda do
          FreeAgent::Project.new(:id => 1).invoices
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
