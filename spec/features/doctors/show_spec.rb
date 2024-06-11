require 'rails_helper'

RSpec.describe "Doctors Show Page" do
  before(:each) do
    @hospital_1 = Hospital.create(name: "Mercy Hospital")
    @hospital_2 = Hospital.create(name: "Jersey Shore Medical Center")
    @hospital_3 = Hospital.create(name: "The Vet")

    @doctor_1 = Doctor.create!(hospital_id: @hospital_1.id, name: "Dr. House", specialty: "Cancer Treatment", university: "Princeton")
    @doctor_2 = Doctor.create!(hospital_id: @hospital_1.id, name: "Dr. Grey", specialty: "Spinal", university: "Notre Dame")
    
    @doctor_3 = Doctor.create!(hospital_id: @hospital_3.id, name: "Dr. Love", specialty: "Emotional Sciences", university: "Harvard")

    @patient_1 = Patient.create(name: "Fred", age: 30)
    @patient_2 = Patient.create(name: "Shaggy", age: 26)
    @patient_3 = Patient.create(name: "Old Man Jenkins", age: 87)
    @patient_4 = Patient.create(name: "Velma", age: 19)
    @patient_5 = Patient.create(name: "Scooby", age: 50) # in dog years

    @doctor_patient_1 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_1)
    @doctor_patient_2 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_2)
    @doctor_patient_3 = DoctorPatient.create!(doctor: @doctor_1, patient: @patient_3)

    @doctor_patient_4 = DoctorPatient.create!(doctor: @doctor_2, patient: @patient_1)
    @doctor_patient_5 = DoctorPatient.create!(doctor: @doctor_2, patient: @patient_4)

    @doctor_patient_5 = DoctorPatient.create!(doctor: @doctor_3, patient: @patient_5)
  end
# User Story 1 - Doctors Show Page
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

      expect(page).to have_content("Name: #{@doctor_1.name}")
      expect(page).to have_content("Specialty: #{@doctor_1.specialty}")
      expect(page).to have_content("University: #{@doctor_1.university}")
      expect(page).to have_content("Hospital: #{@hospital_1.name}")
      
      within("#patients") do 
        expect(page).to have_content("List of Patients")
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_2.name)
        expect(page).to have_content(@patient_3.name)
        expect(page).to_not have_content(@patient_4.name)
        expect(page).to_not have_content(@patient_5.name)
      end
    end
# User Story 2 - Remove a Patient from a Doctor
# As a visitor
# When I visit a Doctor's show page
# Then next to each patient's name, I see a button to remove that patient from that doctor's caseload
# When I click that button for one patient
# I'm brought back to the Doctor's show page
# And I no longer see that patient's name listed
# And when I visit a different doctor's show page that is caring for the same patient,
# Then I see that the patient is still on the other doctor's caseload
    it "next to each patient's name, there is a functional button to remove that patient from that doctor's caseload" do
      visit "/doctors/#{@doctor_1.id}"

      within("#patient-#{@patient_1.id}") do
        expect(page).to have_content(@patient_1.name)
        click_button ("Remove")
      end

      within("#patient-#{@patient_2.id}") do
        expect(page).to have_content(@patient_2.name)
        expect(page).to have_button("Remove")
      end

      within("#patient-#{@patient_3.id}") do
        expect(page).to have_content(@patient_3.name)
        expect(page).to have_button("Remove")
      end

      within("#patients") do 
        expect(page).to_not have_content(@patient_1.name)
        expect(page).to have_content(@patient_2.name)
        expect(page).to have_content(@patient_3.name)
        expect(page).to_not have_content(@patient_4.name)
        expect(page).to_not have_content(@patient_5.name)
      end

      visit "/doctors/#{@doctor_2.id}"

      within("#patients") do 
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_4.name)
      end

      visit "/doctors/#{@doctor_3.id}"

      within("#patients") do 
        expect(page).to have_content(@patient_5.name)
        expect(page).to_not have_content(@patient_1.name)
        expect(page).to_not have_content(@patient_2.name)
        expect(page).to_not have_content(@patient_3.name)
        expect(page).to_not have_content(@patient_4.name)
      end
    end
  end
end