require 'rails_helper'

RSpec.describe "Patients Index Page" do
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
# User Story 3 - Patient Index Page
# As a visitor
# When I visit the patient index page
# I see the names of all adult patients (age is greater than 18),
# And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)
  describe "As a visitor, when I visit a patient index page" do
    it "I see the names of all the adult patients in ascending alphabetical order" do
      visit "/patients"

      expect(page).to have_content("Adult Patients")

      within("#patients") do
 
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_3.name)
      
        expect(page).to_not have_content(@patient_2.name)
        expect(page).to_not have_content(@patient_4.name)
      end
    end
  end
end