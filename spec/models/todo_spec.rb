require 'spec_helper'

describe Todo do
  it "saves itself" do
    todo = Todo.new(name: "cook dinner", description: "I love cooking!")
    todo.save
    Todo.first.name.should == "cook dinner"
  end
end
