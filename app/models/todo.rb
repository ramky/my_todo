class Todo < ActiveRecord::Base
  include Tokenable
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name
  belongs_to :user

  def name_only?
    description.blank?
  end

  def display_text
    name + tag_text
  end

  def save_with_tags(user)
    self.user = user
    if save
      create_location_tags
      true
    else
      false
    end
  end

  def to_param
    token
  end

  def tag_text
    if tags.any?
      " (" +
      "#{ tags.one? ? 'tag' : 'tags' }: " +
      "#{ tags.map(&:name).first(4).join(", ") }" +
      "#{ ', more...' if tags.count > 4 }" +
      ")"
    else
      ""
    end
  end

private
  def create_location_tags
    location_string = name.slice(/.*\bAT\b(.*)/, 1).try(:strip)
    if location_string
      locations = location_string.split(/\,|and/).map(&:strip)
      locations.each do |location|
        tags.create(name: "location:#{location}")
      end
    end
  end
end
