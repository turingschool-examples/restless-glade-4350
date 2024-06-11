class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors
   
  validates_presence_of :name
  
  def doctors_ordered_by_patients
    # didnt get to finish this one :(
  end

end