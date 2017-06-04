class New < ApplicationRecord
  validates :new_date,:show_time_from,:show_time_to,:title, presence: true
  has_one :new_image,:foreign_key => :owner_id,dependent: :destroy
  # validates_format_of :url, :with => /\A((http|ftp|https):\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$\Z/i,:if => proc { |c| !c.path.blank? }

  def get_attachment
    new_image =NewImage.find_by("owner_id = ?","#{self.id}")
    return "" if new_image.blank?
    return "#{new_image.file_path}original_image/#{new_image.file_name}"
  end

  def get_show_flag
    news = New.find(self.id)
    return "" if news.show_flag == false
    return "disabled" if news.show_flag == true
  end

  def get_url
    news = New.find_by(self.id)
    url = news.url
    if url[4] == ":"
      return url.strip[0,7],url.strip[7,99]
    else
      return url.strip[0,8],url.strip[8,99]
    end

  end
end
