class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]


  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    if request.post?
      # conn = [['1 = 1']]
      # if params[:name].present?
      #   conn[0] << 'name like ?'
      #   conn << "%#{params[:name].to_s.strip}%"
      # end
      # if params[:address].present?
      #   conn[0] << 'address like ?'
      #   conn << "%#{params[:address].to_s.strip}%"
      # end
      # if params[:phone].present?
      #   conn[0] << 'phone like ?'
      #   conn << "%#{params[:phone].to_s.strip}%"
      # end
      # conn[0] = conn[0].join(' and ')
      @name = params[:name];@address = params[:address];@phone = params[:phone]
      @shops = Shop.where("name like ? and address like ? and phone like ?","%#{@name}%","%#{@address}%","%#{@phone}%").paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end

  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @shops = Shop.find(params[:id])
    @attachment = Attachment.where("owner_id = ?",params[:id])
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
    @phone1 = (@shop.phone)[0,4]
    @phone2 = (@shop.phone)[4,8]
  end

  # POST /shops
  # POST /shops.json
  def create
    @phone1 = params[:phone1]
    @phone2 = params[:phone2]

    @shop = Shop.new(shop_params)
    @shop.phone = @phone1 + @phone2
    respond_to do |format|
      if @shop.save
        p "123"
        if params[:file_test].present?
          real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/
          shop_image = ShopImage.new
          shop_image.owner_id = @shop.id #不能去掉
          shop_image.file_name = file_name
          shop_image.file_path = real_path
          shop_image.save
        end
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else

        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    p "update,"
    @phone1 = params[:phone1]
    @phone2 = params[:phone2]
    @shop.phone = @phone1 + @phone2
    respond_to do |format|
      if @shop.update(shop_params)
        if params[:file_test].present?
          real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/
          @shopImage = ShopImage.find_by("owner_id = ?",@shop.id)
          if @shopImage.present?
            @shopImage.file_name = file_name
            @shopImage.save
          else
            shop_image = ShopImage.new
            shop_image.owner_id = @shop.id #不能去掉
            shop_image.file_name = file_name
            shop_image.file_path = real_path
            shop_image.save
          end
        end
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to "/shops", notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def image_preview
    p params,"111111111111"
    #获得图片名
    @file_name = Attachment.image_preview(params[:file_test])
    p @file_name,"111"
    respond_to do |format|
      format.html { }
      format.json { }
      format.js {}
    end
  end

  def pre
    p params,"aa"
    @file_name = Attachment.image_preview(params[:file_test])
    p @file_name,"b"
    # respond_to do |format|
    #   format.html { }
    #   format.json { }
    #   format.js {}
    # end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      # params.fetch(})
      params.require(:shop).permit(:name,:address,:phone,:business_hours)
    end
end
