require 'spec_helper'

describe TodosController do
  before { set_current_user }

  describe "GET index" do
    it "sets the @todos variable" do
      cook  = Todo.create(name: "cook", description: "i love cooking")
      sleep = Todo.create(name: "sleep", description: "i love sleeping")

      get :index
      assigns(:todos).should == [cook, sleep]
    end
    it "renders the index templates" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET new" do
    it "sets the @todo variable" do
      get :new
      assigns(:todo).should be_new_record
      assigns(:todo).should be_instance_of(Todo)
    end
    it "renders the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    it "creates the todo record when the input is valid" do
      post :create, todo: { name: "cook", description: "i love cooking" }
      Todo.first.name.should == "cook"
      Todo.first.description.should == "i love cooking"
    end
    it "redirects to the root path when the input is valid" do
      post :create, todo: { name: "cook", description: "i love cooking" }
      response.should redirect_to root_path
    end

    it "does not create the todo record when the input is invalid" do
      post :create, todo: { description: "i love cooking" }
      Todo.count.should == 0
    end

    it "renders the new template when the input is invalid" do
      post :create, todo: { description: "i love cooking" }
      response.should render_template :new
    end

    it "does not create tags without inline locations" do
      post :create, todo: { name: "cook" }
      Tag.count.should == 0
    end

    it "does not create tags with at in the title without inline locations" do
      post :create, todo: { name: "eat an apple" }
      Tag.count.should == 0
    end

    it "creates a tag with upcase AT" do
      post :create, todo: { name: "shop AT the Apple Store" }
      Tag.all.map(&:name).should == ['location:the Apple Store']
    end

    context "with inline locations" do
      it "creates a tag with one location" do
        post :create, todo: { name: "cook AT home" }
        Tag.all.map(&:name).should == ['location:home']
      end

      it "creates two tags with two locations" do
        post :create, todo: { name: "cook AT home and work" }
        Tag.all.map(&:name).should == ['location:home', 'location:work']
      end

      it "creates multiple tags with 4 locations" do
        post :create, todo: { name: "cook AT home, work, school and library" }
        Tag.all.map(&:name).should == ['location:home', 'location:work', 'location:school', 'location:library']
      end

    end
  end
end
