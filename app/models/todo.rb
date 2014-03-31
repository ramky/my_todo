class Todo < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 4}
  validates :description, presence: true
end
