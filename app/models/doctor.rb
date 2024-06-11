class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  validates_presence_of :hospital_id,
                        :name, 
                        :specialty, 
                        :university

  def number_of_patients
    patients.count
  end
end