require 'spec_helper'

describe FreeAgent::Task do

  it "extends FreeAgent::Base" do
    klass.superclass.should == FreeAgent::Base
  end

  describe "paths" do
    it "has correct collection path" do
      FreeAgent::Task.collection_path(:project_id => 1).should == '/projects/1/tasks.xml'
    end

    it "has correct element path" do
      FreeAgent::Task.element_path(:first, :project_id => 1).should == '/projects/1/tasks/first.xml'
      FreeAgent::Task.element_path(100000, :project_id => 1).should == '/projects/1/tasks/100000.xml'
    end
  end


  context "when the project exists" do
    describe ".all" do
      before(:each) do
        @tasks = FreeAgent::Task.all(:params => { :project_id => 2 })
      end

      it "returns an array" do
        @tasks.should be_a(Array)
      end

      it "returns the tasks" do
        @tasks.should have(3).records
        @tasks.first.should be_a(FreeAgent::Task)
      end
    end

    describe ".find(id)" do
      context "when the record exists" do
        before(:each) do
          @task = FreeAgent::Task.find(2, :params => { :project_id => 2 })
        end

        it "returns a task" do
          @task.should be_a(FreeAgent::Task)
        end
      end

      context "when the record does not exist" do
        it "raises a ResourceNotFound error" do
          lambda do
            FreeAgent::Task.find(1, :params => { :project_id => 2 })
          end.should raise_error(ActiveResource::ResourceNotFound)
        end
      end
    end
  end

  context "when the project does not exist" do
    describe ".all" do
      it "raises a ResourceNotFound error" do
        pending 'ActiveResource rescues the error and returns nil'
        lambda do
          FreeAgent::Task.all(:params => { :project_id => 1 })
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end

    describe ".find(id)" do
      it "raises a ResourceNotFound error" do
        lambda do
          FreeAgent::Task.find(1, :params => { :project_id => 1 })
        end.should raise_error(ActiveResource::ResourceNotFound)
      end
    end
  end

end
