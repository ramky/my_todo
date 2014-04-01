require 'spec_helper'

describe Todo do
  describe "#name_only?" do
    it "returns true if the description is nil" do
      todo = Todo.new(name: "cook dinner")
      todo.should be_name_only
    end

    it "returns true if teh description is an empty string" do
      todo = Todo.new(name: "cook dinner", description: "")
      todo.should be_name_only
    end

    it "returns false if the description is a non empty string" do
      todo = Todo.new(name: "cook dinner", description: "Potatoes")
      todo.should_not be_name_only
    end
  end

  describe "#display_text" do
    it "displays the name when there's no tags" do
      todo = Todo.create(name: "cook dinner")
      todo.display_text.should == "cook dinner"
    end

    it "displays the only tag with word 'tag' when there's one tag" do
      todo = Todo.create(name: "cook dinner")
      todo.tags.create(name: "home")
      todo.display_text.should == "cook dinner (tag: home)"
    end

    it "displays name with multiple tags" do
      todo = Todo.create(name: "cook dinner")
      todo.tags.create(name: "home")
      todo.tags.create(name: "urgent")
      todo.display_text.should == "cook dinner (tags: home, urgent)"
    end

    it "display up to four tags" do
      todo = Todo.create(name: "cook dinner")
      todo.tags.create(name: "home")
      todo.tags.create(name: "urgent")
      todo.tags.create(name: "help")
      todo.tags.create(name: "book")
      todo.tags.create(name: "patience")
      todo.display_text.should == "cook dinner (tags: home, urgent, help, book, more...)"
    end
  end
end
