class Todo < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name

  def name_only?
    description.blank?
  end

  def display_text
    return name unless tags.any?
    name + " (#{ tags.one? ? 'tag' : 'tags' }: #{tags.map(&:name).first(4).join(", ")}#{', more...' if tags.count > 4})"
  end
end
