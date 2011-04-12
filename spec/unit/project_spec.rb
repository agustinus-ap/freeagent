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
      @projects.should have(1).attachments
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

end
