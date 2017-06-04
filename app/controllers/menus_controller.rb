class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]


  # GET /menus
  # GET /menus.json
  def index
    # sql = "select s.* from shops s inner join shop_menus sm on sm.shop_id = s.id where sm.menu_id = 1"
    # ss = Shop.find_by_sql(sql)
    # ShopMenu.joins("inner join shops on shop_menus.shop_id = shops.id").select("shops.name").where("shop_menus.menu_id = ?",1)
    @menus = Menu.paginate(:page => params[:page],:per_page=>APP_CONFIG[:per_page])
    if request.post?
      @shops_name = params[:shops_name]; @name = params[:name]; @category = params[:menu][:category_id]
      conn = [['1 = 1']]
      if @shops_name.present?
        conn[0] << 'shops.name like ?'
        conn << "%#{@shops_name.to_s.strip}%"
      end
      if @name.present?
        conn[0] << 'menus.name like ?'
        conn << "%#{@name.to_s.strip}%"
      end
      if @category.to_i != 0
        conn[0] << 'category_id = ?'
        conn << @category
      end
      conn[0] = conn[0].join(' and ')
      @menus = Menu.joins("inner join shop_menus on shop_menus.menu_id = menus.id
inner join shops on shops.id = shop_menus.shop_id").where(conn).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menus = Menu.find(params[:id])
    @attachment = Attachment.where("owner_id = ?",params[:id])
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  def shop_select
    @shops = Shop.paginate(:page=>params[:page],:per_page=>5)
    if request.post?
      @name=params[:name];@address=params[:address];@phone=params[:phone]
      @shops = Shop.where("name like ? and address like ? and phone like ?","%#{@name}%","%#{@address}%","%#{@phone}%").paginate(:page=>params[:page],:per_page=>5)
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    p params,"1"
    @menu = Menu.new(menu_params)
    att = params[:attachments]["1"]["description"].to_s
    att1 = att.gsub("</p>","").gsub("<p>","")[3,4]           #备考选项
    @menu.memo = att1
    if params[:genre1].present? || params[:genre2].present?
      genre = []
      genre << params[:genre1] if params[:genre1] != nil
      genre << params[:genre2] if params[:genre2] != nil
      p @menu.genre = genre
      # @menu.genre = params[:genre]
    end

      respond_to do |format|
        shop_id_arr = params[:shop_id].split(",")
        shop_menu_arr = []
        shop_id_arr.each do |shop_id|
          shop_menu = ShopMenu.new
          shop_menu.shop_id = shop_id
          shop_menu_arr << shop_menu
        end
        @menu.shop_menus = shop_menu_arr

        real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/
        if real_path != nil && file_name != nil
          menu_image = MenuImage.new
          menu_image.file_name = file_name
          menu_image.file_path = real_path
          @menu.menu_image = menu_image
        end

        if @menu.save
          format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
          format.json { render :show, status: :created, location: @menu }
        else
          format.html { render :new }
          format.json { render json: @menu.errors, status: :unprocessable_entity }
        end
      end

  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    p params,"|"
    att = params[:attachments]["1"]["description"].to_s
    att1 = att.gsub("</p>","").gsub("<p>","")[3,4]           #备考选项
    @menu.memo = att1

    if params[:genre1].present? || params[:genre2].present?
      genre = []
      genre << params[:genre1] if params[:genre1] != nil
      genre << params[:genre2] if params[:genre2] != nil
      p @menu.genre = genre
      # @menu.genre = params[:genre]
    end

    respond_to do |format|
      shopId = Menu.find(@menu.id).get_shop_id
      @shopsId = shopId.to_s.gsub(" ","").gsub("[","").gsub("]","")
      if @shopsId != params[:shop_id] || @shopsId !=nil #相等不动
        @shop_menu = ShopMenu.where("menu_id = ?",params[:id])
        @shop_menu.delete_all
        shop_menu_id = params[:shop_id].split(",")
        shop_menu_arr = []
        shop_menu_id.each do |shop_id|
          shop_menu = ShopMenu.new
          shop_menu.shop_id = shop_id
          shop_menu_arr << shop_menu
        end
        @menu.shop_menus = shop_menu_arr
      end

      if params[:file_test].present?
        real_path, file_name = Attachment.upload(params[:file_test])
        @menuImage = MenuImage.find_by("owner_id = ?",@menu.id)
        if @menuImage.present?
          @menuImage.file_name = file_name
          @menuImage.save
        else
          menu_image = MenuImage.new
          menu_image.file_name = file_name
          menu_image.file_path = real_path
          @menu.menu_image = menu_image
        end
      end

      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to "/menus", notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      # params.fetch(:menu, {})
      params.require(:menu).permit(:category_id,:name,:genre,:price,:calorie,:salt,:memo)
    end
end
