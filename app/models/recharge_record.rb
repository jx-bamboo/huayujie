class RechargeRecord < ApplicationRecord
  belongs_to :user
  def get_user
    userId = RechargeRecord.find(self.id).user_id
    return User.find(userId)
  end

 def self.search_sql(params = {})
   @login = params[:login];@name = params[:name];@from = params[:from];@to = params[:to]
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
    recharge_record = RechargeRecord.joins("inner join users on users.id = recharge_records.user_id").where(RechargeRecord.search_sql(params))
    output = CSV.generate do |csv|
      csv << %w(用戶名 姓名 性別 電話 郵箱 充值積分 總積分 充值日期)
      unless recharge_record.blank?
        recharge_record.each_with_index do |record, index|
          GC.start if index % 100 == 0
          line_item = []
          line_item << ( record.get_user.login )
          line_item << ( record.get_user.name )
          line_item << ( record.get_user.sex )
          line_item << ( record.get_user.phone )
          line_item << ( record.get_user.email )
          line_item << ( record.try(:recharge_point) )
          line_item << ( record.try(:total_point) )
          line_item << ( record.try(:recharge_date).strftime("%Y-%m-%d %H:%M:%S") rescue "" )
          # line_item << ( record.try(:email) )
          # line_item << ( record.try(:created_at).strftime("%Y-%m-%d %H:%M:%S") rescue "")
          # line_item << ( record.try(:updated_at).strftime("%Y-%m-%d %H:%M:%S") rescue "")

          csv << line_item
        end
      end
    end
    # NKF.nkf('-wLuxs', output)
  end


end
