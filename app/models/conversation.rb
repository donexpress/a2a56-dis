class Conversation < ApplicationRecord
  WA_SENDER_PHONE_NUMBER = '56959261264'

  validates :client_phone_number, presence: true
  validates :business_phone_number, presence: true
  validate :check_client_phone_number

  validates_uniqueness_of :client_phone_number, scope: :business_phone_number

  after_initialize :initialize_callback

  private

  def initialize_callback
    self.business_phone_number = WA_SENDER_PHONE_NUMBER
  end

  def check_client_phone_number
    return if client_phone_number.nil?

    if client_phone_number.starts_with?('569')
      if client_phone_number.length != 11
        errors.add(:client_phone_number, 'Chilean numbers require 8-digits followed after the country code and mobile fixed digit')
      end
    else
      errors.add(:client_phone_number, 'Cannot send message to this number. Check for the correct country code.')
    end
  end
end
