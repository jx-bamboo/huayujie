class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  before_action :login_in, :except => [:login, :logout]
  # layout nil,:only => [:shop_select]
  def login_in
    if session[:admin].blank?
      pp "asdf"
      redirect_to "/admins/login"
      return true
    end
  end

  def send_csv_by_brower_type(output, time = Time.now, format = '%Y%m%d%H%M%S')
    if time.is_a? Array
      time = [time.first.blank? ? '' : time.first.strftime(format).to_s, time.last.blank? ? '' : time.last.strftime(format).to_s].uniq.join('~')
    else
      time = time.strftime(format).to_s
    end
    case judage_brower_type(request.env['HTTP_USER_AGENT'])
      when 'IE'
        send_data(output, :type => 'text/csv',  :filename => "#{ URI::encode(@name)}_#{time}.csv")
      when 'Firefox'
        send_data(output, :type => 'text/csv', :filename => "#{@name}_#{time}.csv")
      when 'Safari'
        send_data(output, :type => 'text/csv', :filename => "#{@name}_#{time}.csv")
      else
        send_data(output, :type => 'text/csv', :filename => "#{ URI::encode(@name)}_#{time}.csv")
    end
  end

  def judage_brower_type(http_user_agent)
    return 'Firefox' if http_user_agent.include?('Firefox')
    return 'Safari' if http_user_agent.include?('Safari')
    return 'IE' if http_user_agent.include?('MSIE')
    'IE'
  end


end
