class Link < ActiveRecord::Base
acts_as_votable


  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: {case_sensitive: false},
                    length: {in: 5..150}
  validates :url,   presence: true,
                    uniqueness: {case_sensitive: false},
                    length: {in: 5..150}

  validates :url, :format => URI::regexp(%w(http https))   

       

end