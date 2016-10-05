class Model < ActiveRecord::Base
  belongs_to :service
  validates :service, presence: true
  validates :name, presence: true, uniqueness: true
end
