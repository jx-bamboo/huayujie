class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    if request.post?
      @name = params[:name]; @from = params[:from]; @to = params[:to]
      conn = [['1 = 1']]
      if @name.present?
        conn[0] << 'name like ?'
        conn << "%#{@name.to_s.strip}%"
      end
      if @from.present?
        conn[0] << 'limit_from <= ?'
        conn << @from
      end
      if @to.present?
        conn[0] << 'limit_to >= ?'
        conn << @to
      end
      conn[0] = conn[0].join(' and ')
      @coupons = Coupon.where(conn).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupons = Coupon.find(params[:id])
    @attachment = Attachment.where("owner_id = ?",params[:id])
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)
      respond_to do |format|
        shop_coupon_id = params[:shop_id].split(",")
        shop_coupon_arr = []
        shop_coupon_id.each do |shop_id|
          shop_coupon = ShopCoupon.new
          shop_coupon.shop_id = shop_id
          shop_coupon_arr << shop_coupon
        end
        @coupon.shop_coupons = shop_coupon_arr
        real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/

        if file_name.present? && real_path.present?
          coupon_image = CouponImage.new
          coupon_image.file_name = file_name
          coupon_image.file_path = real_path
          @coupon.coupon_image = coupon_image
        end

        if @coupon.save
          format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
          format.json { render :show, status: :created, location: @coupon }
        else
          format.html { render :new }
          format.json { render json: @coupon.errors, status: :unprocessable_entity }
        end
      end

  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    p params,"|"
    respond_to do |format|
      #外键存储
      shopId = Coupon.find(@coupon.id).get_shop_id
      @shopsId = shopId.to_s.gsub(" ","").gsub("[","").gsub("]","")
      if @shopsId != params[:shop_id] || @shopsId != nil
        @shop_coupon = ShopCoupon.where("coupon_id = ?",params[:id])
        @shop_coupon.delete_all
        shop_coupon = params[:shop_id].split(",")
        shop_couopon_arr = []
        shop_coupon.each do |shop_id|
          shop_menu = ShopCoupon.new
          shop_menu.shop_id = shop_id
          shop_couopon_arr << shop_menu
        end
        @coupon.shop_coupons = shop_couopon_arr
      end

      #图片
      p params[:file_test],"1"
      if params[:file_test].present?
        real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/
        @couponImage = CouponImage.find_by("owner_id = ?",@coupon.id)
        if @couponImage.present?
          @couponImage.file_name = file_name
          @couponImage.save
        else
          coupon_image = CouponImage.new
          coupon_image.file_name = file_name
          coupon_image.file_path = real_path
          @coupon.coupon_image = coupon_image
        end
      end
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to "/coupons", notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      # params.fetch(:coupon, {})
      params.require(:coupon).permit(:name,:limit_from,:limit_to,:price,:send_object)
    end
end
