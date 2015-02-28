require 'rails_helper'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: "555-1234")
    person.phone_numbers.create(number: "555-3254")
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it "has a link to add a new phone number" do
    expect(page).to have_link('Add Phone Number', href: new_phone_number_path(person_id: person.id))
  end

  it "adds a new phone number" do
    page.click_link("Add Phone Number")
    page.fill_in('Number', with:"5958777")
    page.click_button('Create')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('5958777')
  end

  it 'has links to edit phone numbers' do
    person.phone_numbers.each do |number|
    expect(page).to have_link("Edit", href: edit_phone_number_path(number))
    end
  end

  it 'edits a phone number' do
    phone = person.phone_numbers.first
    old_number = phone.number
    first(:link, 'Edit').click
    page.fill_in("Number", with: '4446565')
    page.click_button('Update')
    expect(current_path).to eq(person_path(person))
    expect(page).to_not have_content(old_number)
  end

  it 'has links to delete phone numbers' do
    person.phone_numbers.each do |number|
      expect(page).to have_link("Delete", href: phone_number_path(number))
    end
  end

  it 'deletes a phone number' do
    phone = person.phone_numbers.first
    expect(page).to have_content(phone.number)
    first(:link, 'Delete').click
    expect(current_path).to eq(person_path(person))
    expect(page).not_to have_content(phone)
  end
end
