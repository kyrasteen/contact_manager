require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person) do
    Person.new(first_name: 'Alice', last_name: 'Smith')
  end

  it "is invalid without a first name" do
    person.first_name = nil
    expect(person).not_to be_valid
  end

  it "is invalid without a last name" do
    person.last_name = nil
    expect(person).not_to be_valid
  end

  it "convert to a string with last name, first name" do
    expect(person.to_s).to eq "Smith, Alice"
  end

  it "responds with its created phone numbers" do
    person.phone_numbers.build(number: '4444444')
    expect(person.phone_numbers.map(&:number)).to eq(["4444444"])
  end

  it "has an array of email addresses" do
    person.email_addresses.build(address: 'me@example.com')
    expect(person.email_addresses.map(&:address)).to eq(["me@example.com"])
  end
end
