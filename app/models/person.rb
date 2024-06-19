# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

class Person < ApplicationRecord
  belongs_to :company, optional: true

  attr_accessor :email_confirmation

  validates :email, presence: true, uniqueness: true
  validates :email_confirmation, presence: true, if: -> { email.present? }
  validate :email_matches_confirmation

  private
  def email_matches_confirmation
    if email != email_confirmation
      errors.add(:email_confirmation, "doesn't match Email")
    end
  end
end
