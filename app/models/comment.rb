class Comment < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :link, dependent: :destroy

  validates :body, length: {in: 2..200}
end
