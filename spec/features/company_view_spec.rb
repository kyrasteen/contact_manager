require 'rails_helper'

describe 'the contact view', type: :feature do
    let(:contact) { Company.create(name: 'Basin') }
  describe 'phone_numbers', type: :feature do

    before(:each) do
      contact.phone_numbers.create(number: "555-1234", contact_id: contact.id, contact_type:'Company' )
      contact.phone_numbers.create(number: "555-3254", contact_id: contact.id, contact_type:'Company')
      visit company_path(contact)
    end

    it 'shows the phone numbers' do
      contact.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it "has a link to add a new phone number" do
      expect(page).to have_link('Add Phone Number', href: new_phone_number_path(contact_id: contact.id, contact_type: "Company"))
    end

    it "adds a new phone number" do
      page.click_link("Add Phone Number")
      page.fill_in('Number', with:"5958777")
      page.click_button('Create')
      expect(current_path).to eq(company_path(contact))
      expect(page).to have_content('5958777')
    end

    it 'has links to edit phone numbers' do
      contact.phone_numbers.each do |number|
      expect(page).to have_link("Edit", href: edit_phone_number_path(number))
      end
    end

    it 'edits a phone number' do
      phone = contact.phone_numbers.first
      old_number = phone.number
      first(:link, 'Edit').click
      page.fill_in("Number", with: '4446565')
      page.click_button('Update')
      expect(current_path).to eq(company_path(contact))
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      contact.phone_numbers.each do |number|
        expect(page).to have_link("Delete", href: phone_number_path(number))
      end
    end

    it 'deletes a phone number' do
      phone = contact.phone_numbers.first
      expect(page).to have_content(phone.number)
      first(:link, 'Delete').click
      expect(current_path).to eq(company_path(contact))
      expect(page).not_to have_content(phone)
    end

  describe 'email_addresses', type: :feature do

    before(:each) do
      contact.email_addresses.create(address:'myadd@example.com', contact_id: contact.id, contact_type: 'Company')
      contact.email_addresses.create(address:'diffadd@example.com', contact_id: contact.id, contact_type: 'Company')
      visit company_path(contact)
    end

    it 'shows the email addresses' do
      expect(page).to have_selector('li', text: 'diffadd@example.com')
    end

    it 'has an add email address link' do
      expect(page).to have_selector('a#new_email_address')
    end

    it 'adds an email address' do
      page.click_link("Add Email Address")
      expect(current_url).to eq('http://www.example.com/email_addresses/new?contact_id=1&contact_type=Company')
      page.fill_in('Address', with:"kw@example.com")
      page.click_button('Create')
      expect(current_path).to eq(company_path(contact))
      expect(page).to have_content('kw@example.com')
    end

    it 'has links to edit email addresses' do
      contact.email_addresses.each do |email|
      expect(page).to have_link("Edit", href: edit_email_address_path(email))
      end
    end

    it 'edits a email address' do
      email = contact.email_addresses.first
      old_address = email.address
      first('.emails').click_link('Edit')
      page.fill_in("Address", with: 'k4yy@example.com')
      page.click_button('Update')
      expect(current_path).to eq(company_path(contact))
      expect(page).to_not have_content(old_address)
    end

    it 'deletes a email address' do
      email = contact.email_addresses.first
      expect(page).to have_content(email.address)
      first(:link, 'Delete').click
      expect(current_path).to eq(company_path(contact))
      expect(page).not_to have_content(email)
    end
end
  end
end
