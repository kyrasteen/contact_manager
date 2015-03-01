require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email_address) { EmailAddress.new(address: 'kyra.steenbock@example.com', contact_id: 1, contact_type: "Person")}

  it "is valid" do
    expect(email_address).to be_valid
  end

  it "is invalid without address" do
    email_address.address = nil
    expect(email_address).not_to be_valid
  end

  it "is invalid without a person id" do
    expect(email_address.contact_id).to eq(1)
  end
end
