require 'rails_helper'


RSpec.describe "Gardens Show Page" do
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
  # User Story 1, Doctors Show Page
  # ​
  # As a visitor
  # When I visit a doctor's show page
  # I see all of that doctor's information including:
  #  - name
  #  - specialty
  #  - university where they got their doctorate
  # And I see the name of the hospital where this doctor works
  # And I see the names of all of the patients this doctor has
  describe "As a visitor, when I visit a doctors show page" do
    it "has the doctor's name, specialy, university, hospital name, and patients" do
      visit "/doctors/#{@doctor_1.id}"
      # save_and_open_page
      expect(page).to have_content("Name: #{@doctor_1.name}")
      expect(page).to have_content("Specialty: #{@doctor_1.specialty}")
      expect(page).to have_content("University: #{@doctor_1.university}")
      # binding.pry
      expect(page).to have_content(@hospital_1.name)
      
      within("#patients") do 
        expect(page).to have_content("List of Patients")
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_2.name)
        expect(page).to have_content(@patient_3.name)
      end
    end
  end
end