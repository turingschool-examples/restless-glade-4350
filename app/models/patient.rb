class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
  validates_presence_of :name, 
                        :age
  validates_numericality_of :age, only_integer: true

  def self.alphabetical_adults
    where("age >  18").order(:name)
  end
end