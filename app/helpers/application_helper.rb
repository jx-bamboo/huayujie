module ApplicationHelper

  def change_title
    if params[:controller] == 'shops'
      id = "b_sn1"
      clas = "sub01"
      title = "店鋪管理"
    elsif params[:controller] == "menus" || params[:controller] == "categories"
      id = "b_sn2"
      clas = "sub02"
      title = "菜單管理"
    elsif params[:controller] == "coupons"
      id = "b_sn3"
      clas = "sub03"
      title = "優惠券管理"
    elsif params[:controller] == "users"
      id = "b_sn4"
      clas = "sub04"
      title = "會員管理"
    elsif params[:controller] == "systems" && params[:action] == "index"
      id = "b_sn5"
      clas = "sub05"
      title = "充值記錄一覽"
    elsif params[:controller] == "systems" && params[:action] == "buy"
      id = "b_sn6"
      clas = "sub06"
      title = "買賣記錄一覽"
    elsif params[:controller] == "news"
      id = "b_sn7"
      clas = "sub07"
      title = "新聞管理"
    elsif params[:controller] == "messages"
      id = "b_sn7"
      clas = "sub07"
      title = "信息管理"
    elsif params[:controller] == "admins"
      id = "b_sn7"
      clas = "sub07"
      title = "管理者管理"
    elsif params[:controller] == "inquiries"
      id = "b_sn7"
      clas = "sub07"
      title = "詢問管理"
    elsif params[:controller] == "faqs"
      id = "b_sn7"
      clas = "sub07"
      title = "常見問題管理"
    elsif params[:controller] == "rules"
      id = "b_sn7"
      clas = "sub07"
      title = "使用條款管理"

    end
    return id,clas,title
  end



  # params[:controller] == "news" || params[:controller] == "messages" || params[:controller] == "admins" || params[:controller] == "faqs" || params[:controller] == "inquiries"

end
