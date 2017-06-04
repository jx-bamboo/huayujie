class User < ApplicationRecord
  validates :login,:name,:email,:password,:phone,:sex,:birthday,presence: true
  validates :password, confirmation: true
  validates :password_confirmation,presence: true
  validates :password,:password_confirmation,length: {minimum: 6}
  validates_length_of :phone,:in => 8..11
  validates_format_of :email,:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_many :recharge_records
  has_many :buy_records

  def change_birthday
    birth = User.find(self.id)
    month = birth.birthday.strftime("%m")
    day = birth.birthday.strftime("%d")
    return month,day
  end

  def get_sex
    user = User.find(self.id)
    return "男" if user.sex == 1
    return "女" if user.sex == 0
  end
end
