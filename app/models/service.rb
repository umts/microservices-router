class Service < ActiveRecord::Base
  has_many :models
  validates :url, presence: true, uniqueness: true
end
