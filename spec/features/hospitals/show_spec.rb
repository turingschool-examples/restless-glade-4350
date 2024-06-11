require 'rails_helper'

RSpec.describe "Hospitals Show Page" do
  before(:each) do
    @hospital_1 = Hospital.create(name: "Mercy Hospital")
    @hospital_2 = Hospital.create(name: "Jersey Shore Medical Center")

    @doctor_1 = Doctor.create!(hospital_id: @hospital_1.id, name: "Dr. House", specialty: "Cancer Treatment", university: "Princeton")
    @doctor_2 = Doctor.create!(hospital_id: @hospital_1.id, name: "Dr. Grey", specialty: "Spinal", university: "Notre Dame")
    
    @doctor_3 = Doctor.create!(hospital_id: @hospital_2.id, name: "Dr. Love", specialty: "Emotional Sciences", university: "Harvard")

    @patient_1 = Patient.create(name: "Fred", age: 30)
    @patient_2 = Patient.create(name: "Shaggy", age: 26)
    @patient_3 = Patient.create(name: "Old Man Jenkins", age: 87)

    @doctor_patient_1 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_1)
    @doctor_patient_2 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_2)
    @doctor_patient_3 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_3)

    @doctor_patient_4 = DoctorPatient.create!(doctor: @doctor_2, patient: @patient_1)
  end

# Extension, Hospital Show Page
# ​
# As a visitor
# When I visit a hospital's show page
# I see the hospital's name
# And I see the names of all doctors that work at this hospital,
# And next to each doctor I see the number of patients associated with the doctor,
# And I see the list of doctors is ordered from most number of patients to least number of patients
# (Doctor patient counts should be a single query)
  describe "As a visitor, when I visit a hospital's show page" do
    it "I see the hospital's name and all of its doctors in order of most patients to least patients" do
      visit "/hospitals/#{@hospital_1.id}"

      expect(page).to have_content("Hospital: #{@hospital_1.name}")

      within("#doctors") do
        expect(page).to have_content("List of Doctors")
        expect(page).to have_content(@doctor_1.name)
        expect(page).to have_content(@doctor_2.name)
      end
      
      within("#doctor-#{@doctor_1.id}") do
        expect(page).to have_content("Number of Patients: 3")
      end

      within("#doctor-#{@doctor_2.id}") do
        expect(page).to have_content("Number of Patients: 1")
      end
    end
  end
end