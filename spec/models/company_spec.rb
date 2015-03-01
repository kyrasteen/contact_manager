require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { Company.create(name: "my company") }

  it "is valid" do
    expect(company).to be_valid
  end

  it "is not valid without a name" do
    company.name = nil
    expect(company).not_to be_valid
  end

  it "has an array of phone numbers" do
    phone_number = company.phone_numbers.build(number: "3334433")
    expect(phone_number.number).to eq("3334433")
  end

  it "convert to a string with name" do
    expect(company.to_s).to eq "my company"
  end
end
