class EmailAddress < ActiveRecord::Base
  validates :address, :contact_id, :contact_type, presence: true
  belongs_to :contact, polymorphic: true
end
