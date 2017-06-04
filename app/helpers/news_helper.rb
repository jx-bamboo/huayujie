module NewsHelper
  def get_action
    return "/news/create" if params[:action] == "new"
  end
end
