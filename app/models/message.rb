class Message < ApplicationRecord
  validates :title,:content,:start_time,presence: true
  belongs_to :admin
  def get_send_object
    msg = Message.find(self.id)
    if msg.send_object == 0
      return "所有人"
    else
      return User.find(msg.send_object).try(:name)
    end
  end

  def get_so
    msg = Message.find(self.id)
    p msg.send_object,"|"
    if msg.send_object == 0
      return "checked"
    else
      return ""
    end
  end

end
