class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors
   
  validates_presence_of :name
end