require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit a surgerys show page' do
    before(:each) do
      # Hospitals:
      @hospital1 = Hospital.create(name: "Seattle Grace")
      @hospital2 = Hospital.create(name: "New York Hospital")
      # Doctors:
      @doctor1 = Doctor.create!(hospital_id: @hospital1.id, name: "Meredith Grey", specialty: "General Surgery", university_attended: "Harvard University")
      @doctor2 = Doctor.create!(hospital_id: @hospital1.id, name: "Alex Karev", specialty: "Pediatric Surgery", university_attended: "Johns Hopkins University")
      @doctor3 = Doctor.create!(hospital_id: @hospital2.id, name: "Miranda Bailey", specialty: "General Surgery", university_attended: "Stanford University")
      @doctor4 = Doctor.create!(hospital_id: @hospital2.id,name: "Derek Webber", specialty: "Attending Surgeon", university_attended: "University of Pennsylvania")
      # Surgeries:
      @surgery1 = Surgery.create!(title: 'Knee Replacement', day_of_week: 'Thursday', operating_room_number: 4)
      @surgery2 = Surgery.create!(title: 'Spinal Fusion', day_of_week: 'Thursday', operating_room_number: 3)
      # Doctor Surgeries: 
      DoctorSurgery.create!(surgery_id: @surgery1.id, doctor_id: @doctor1.id)
      DoctorSurgery.create!(surgery_id: @surgery1.id, doctor_id: @doctor2.id)
      DoctorSurgery.create!(surgery_id: @surgery2.id, doctor_id: @doctor3.id)
      DoctorSurgery.create!(surgery_id: @surgery2.id, doctor_id: @doctor4.id)
    end
    # User Story 2
    describe 'Surgery Index' do
      it 'I can click on any surgery title and go to surgery’s show page and see all the surgerys details' do
        visit surgeries_path
     
        expect(page).to have_link(@surgery1.title)
        
        click_link(@surgery1.title)

        expect(current_path).to eq(surgery_path(@surgery1))
        expect(page).to have_content(@surgery1.title)
        expect(page).to have_content(@surgery1.operating_room_number)
        expect(page).to have_content('Other surgeries happening this day of the week:')
        expect(@surgery2.title).to_not appear_before('Other surgeries happening this day of the week:')
        save_and_open_page
      end
    end
  end
end