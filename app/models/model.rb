class Model < ActiveRecord::Base
  belongs_to :service
  validates :name, presence: true, uniqueness: true
end
