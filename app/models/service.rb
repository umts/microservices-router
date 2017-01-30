class Service < ActiveRecord::Base
  has_many :models, dependent: :destroy
  validates :url, presence: true, uniqueness: true
end
