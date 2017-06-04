class Admin < ApplicationRecord
  validates :login,:name,:password,:email,presence: true
  validates :login,:name,uniqueness: true
  validates :password,confirmation: true
  validates :password_confirmation,presence: true
  # validates_length_of :phone,:in => 8..11
  validates_format_of :email,:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_many :messages
  has_many :message_update_records

end
