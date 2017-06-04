class Menu < ApplicationRecord
  validates :name,:category_id,:genre,:price,:calorie,:salt, presence: true
  validates :name,uniqueness: true
  validates_presence_of :menu_image,:shop_menus,message: "不能為空字符"

  has_one :menu_image, :foreign_key => :owner_id, dependent: :destroy
  belongs_to :category
  has_many :shops, :through => :shop_menus
  has_many :shop_menus,dependent: :destroy
  has_many :buy_records

  def get_shop_name
    self.shops.collect{|shop| shop.name}
  end

  def get_shop_id
    self.shops.collect{|shop| shop.id}
  end

  def get_attachment
    menu_image = MenuImage.find_by("owner_id = ?","#{self.id}")
    return '' if menu_image.blank?
    return "#{menu_image.file_path}original_image/#{menu_image.file_name}"
  end

  def get_genre
    menu_genre = Menu.find(self.id)
    menu = menu_genre.genre.split(",")
    case
      when menu.length==1
        if menu[0][2].to_i==1
          return "常規菜單"
        end
        if menu[0][2].to_i==2
          return "每週菜單"
        end
      when menu.length==2
        return "常規菜單,常規菜單"
    end
  end
end
