class Page < ActiveRecord::Base
  attr_accessible :content, :sidebar, :title
  belongs_to :account

  validates :content, presence: true
  validates :title, presence: true
end
