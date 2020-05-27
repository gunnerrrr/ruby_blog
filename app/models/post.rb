class Post < ApplicationRecord
validates :title, :author, :summary, :body, presence: true
belongs_to :user
validates :user_id, presence: true
has_many :taggings, dependent: :destroy
has_many :tags, through: :taggings
has_many :saves, dependent: :destroy
def post_tags
    self.tags.map(&:name).join(', ')
end
def post_tags=(names)
    self.tags= names.split(', ').map do |name|
        if( name[0] == "#")
            name = name[1..-1]
        end
        Tag.where(name: name.strip.prepend("#")).first_or_create!
    end
end
end
