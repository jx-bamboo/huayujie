class BuyRecord < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :menu

  def get_user
    userId = RechargeRecord.find(self.id).user_id
    return User.find(userId)
  end

  def self.search_sql(params = {})
    @user_login = params[:user_login];@shop_name = params[:shop_name];@menu_name = params[:menu_name];@from = params[:from];@to = params[:to]
    conn = [['1 = 1']]
    if @user_login.present?
      conn[0] << 'users.login like ?'
      conn << "%#{@user_login.to_s.strip}%"
    end
    if @shop_name.present?
      conn[0] << 'shops.name like ?'
      conn << "%#{@shop_name.to_s.strip}%"
    end
    if @menu_name.present?
      conn[0] << 'menus.name like ?'
      conn << "%#{@menu_name.to_s.strip}%"
    end
    if @from.present? || @to.present?
      conn[0] << 'buy_records.buy_date <= ?'
      conn << @from
    end
    if @to.present? && @from.blank?
      conn[0] << 'buy_records.buy_date >= ?'
      conn << @to
    end
    conn[0] = conn[0].join(' and ')
  end


  def self.csv_export(params = {})

    buy_records = BuyRecord.joins("inner join users on users.id = buy_records.user_id
inner join shops on shops.id = buy_records.shop_id
inner join menus on menus.id = buy_records.menu_id").where(BuyRecord.search_sql(params))
    output = CSV.generate do |csv|
      csv << %w(用戶名 姓名 性別 電話 郵箱 店鋪名 菜單名 價格 購買日期)
      unless buy_records.blank?
        buy_records.each_with_index do |record, index|
          GC.start if index % 100 == 0
          line_item = []
          line_item << ( record.get_user.login )
          line_item << ( record.get_user.name )
          line_item << ( record.get_user.sex )
          line_item << ( record.get_user.phone )
          line_item << ( record.get_user.email )
          line_item << ( record.shop.name )
          line_item << ( record.menu.name )
          line_item << ( record.try(:price) )
          line_item << ( record.try(:buy_date).strftime("%Y-%m-%d %H:%M:%S") rescue "" )
          # line_item << ( record.try(:email) )
          # line_item << ( record.try(:created_at).strftime("%Y-%m-%d %H:%M:%S") rescue "")
          # line_item << ( record.try(:updated_at).strftime("%Y-%m-%d %H:%M:%S") rescue "")
          # line_item = "\xEF\xBB\xBF".split(' ').map{|a|a.hex.chr}.join()
          csv << line_item
        end
      end
    end
    # NKF.nkf('-wLuxs', output)
    # File.open("#{Rails.root}/tmp/export_not_equal_introduce_works.csv", "w+"){|file| file.puts(NKF.nkf("-s",output))}
  end

end
