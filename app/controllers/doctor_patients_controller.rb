class DoctorPatientsController < ApplicationController
  
  def destroy
    doctor = Doctor.find(params[:id])
    DoctorPatient.find_by(doctor_id: params[:id], patient_id: params[:format]).destroy
    redirect_to "/doctors/#{doctor.id}"
  end
  
end