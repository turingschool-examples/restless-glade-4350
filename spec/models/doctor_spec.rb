require 'rails_helper'

RSpec.describe Doctor do
  describe "relationships" do
    it { should belong_to :hospital }
    it { should have_many :doctor_patients } 
    it { should have_many(:patients).through(:doctor_patients) }
  end

  describe "validations" do
    it { should validate_presence_of :hospital_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :specialty }
    it { should validate_presence_of :university }
  end

  before(:each) do 
    @hospital_1 = Hospital.create(name: "Mercy Hospital")
    @hospital_2 = Hospital.create(name: "Jersey Shore Medical Center")

    @doctor_1 = Doctor.create!(hospital_id: @hospital_1.id, name: "Dr. House", specialty: "Cancer Treatment", university: "Princeton")
    @doctor_2 = Doctor.create!(hospital_id: @hospital_1.id, name: "Dr. Grey", specialty: "Spinal", university: "Notre Dame")
    
    @doctor_3 = Doctor.create!(hospital_id: @hospital_2.id, name: "Dr. Love", specialty: "Emotional Sciences", university: "Harvard")

    @patient_1 = Patient.create(name: "Fred", age: 19)
    @patient_2 = Patient.create(name: "Shaggy", age: 17)
    @patient_3 = Patient.create(name: "Old Man Jenkins", age: 87)
    @patient_4 = Patient.create(name: "Daphne", age: 18)

    @doctor_patient_1 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_1)
    @doctor_patient_2 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_2)
    @doctor_patient_3 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_3)

    @doctor_patient_4 = DoctorPatient.create!(doctor: @doctor_2, patient: @patient_1)
  end
  describe "instance methods" do
    it "number_of_patients" do
      expect(@doctor_1.number_of_patients).to eq(3)
      expect(@doctor_2.number_of_patients).to eq(1)
      expect(@doctor_3.number_of_patients).to eq(0)
    end
  end
end