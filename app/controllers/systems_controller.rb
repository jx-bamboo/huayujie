class SystemsController < ApplicationController
  before_action :set_system, only: [:show, :edit, :update, :destroy]

  # GET /systems
  # GET /systems.json
  def index
    # @systems = System.all
    @recharge = RechargeRecord.paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    if request.post?
      @login = params[:login];@name = params[:name];@from = params[:from];@to = params[:to]
      conn = [['1 = 1']]
      if @login.present?
        conn[0] << 'users.login like ?'
        conn << "%#{@login.to_s.strip}%"
      end
      if @name.present?
        conn[0] << 'users.name like ?'
        conn << "%#{@name.to_s.strip}%"
      end
      if @from.present? || @to.present?
        conn[0] << 'recharge_records.recharge_date <= ?'
        conn << @from
      end
      if @to.present? && @from.blank?
        conn[0] << 'recharge_records.recharge_date >= ?'
        conn << @to
      end
      conn[0] = conn[0].join(' and ')
      @recharge = RechargeRecord.joins("inner join users on users.id = recharge_records.user_id").where(conn).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end

  end

  def buy
    @buy = BuyRecord.paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    if request.post?
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
      join = "inner join users on users.id = buy_records.user_id inner join shops on shops.id = buy_records.shop_id inner join menus on menus.id = buy_records.menu_id"
      @buy = BuyRecord.joins(join).where(conn).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end
  end

  def get_money
    p params,"|"
    @recharge = RechargeRecord.find(1)
    @recharge.recharge_point = params[:pointsg] if params[:pointsg].present? && params[:input_p].blank?
    @recharge.recharge_point = params[:input_p].to_i if params[:pointsg].to_i == 600
    p @recharge.recharge_point
    @recharge.total_point += @recharge.recharge_point
    @recharge.recharge_date = Time.now
    @recharge.save
  end

  def csv_export
    flag = 1
    if flag
      options = JSON.parse(params[:options])
      if RechargeRecord.search_sql(options).blank?
        flash[:error] = "ダウンロードしていないデータ提供。"
        redirect_to '/systems'
      else
        options ||= {}
        options.symbolize_keys! if options.present?
        @name = '充值記錄一覽' # 文件名
        output = RechargeRecord.csv_export(options || {})
        send_csv_by_brower_type(output)
      end
    else
      options = JSON.parse(params[:options])
      if RechargeRecord.search_sql(options).blank?
        flash[:error] = "ダウンロードしていないデータ提供。"
        redirect_to '/systems'
      else
        options ||= {}
        options.symbolize_keys! if options.present?
        @name = '充值記錄一覽' # 文件名
        output = RechargeRecord.csv_export(options || {})
        send_csv_by_brower_type(NKF.nkf("-s",output))
      end
    end
  end

  def csv_export_buy
    flag = 1
    if flag
      options = JSON.parse(params[:options])
      if BuyRecord.search_sql(options).blank?
        flash[:error] = "ダウンロードしていないデータ提供。"
        redirect_to '/systems/buy'
      else
        options ||= {}
        options.symbolize_keys! if options.present?
        @name = '購買記錄一覽' # 文件名
        output = BuyRecord.csv_export(options || {})
        send_csv_by_brower_type(output)
      end
    else
      options = JSON.parse(params[:options])
      if BuyRecord.search_sql(options).blank?
        flash[:error] = "ダウンロードしていないデータ提供。"
        redirect_to '/systems/buy'
      else
        options ||= {}
        options.symbolize_keys! if options.present?
        @name = '購買記錄一覽' # 文件名
        output = BuyRecord.csv_export(options || {})
        send_csv_by_brower_type(NKF.nkf("-s",output))
      end
    end
  end

  # GET /systems/1
  # GET /systems/1.json
  def show
  end

  # GET /systems/new
  def new
    @system = System.new
  end

  # GET /systems/1/edit
  def edit
  end

  # POST /systems
  # POST /systems.json
  def create
    @system = System.new(system_params)

    respond_to do |format|
      if @system.save
        format.html { redirect_to @system, notice: 'System was successfully created.' }
        format.json { render :show, status: :created, location: @system }
      else
        format.html { render :new }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /systems/1
  # PATCH/PUT /systems/1.json
  def update
    respond_to do |format|
      if @system.update(system_params)
        format.html { redirect_to @system, notice: 'System was successfully updated.' }
        format.json { render :show, status: :ok, location: @system }
      else
        format.html { render :edit }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systems/1
  # DELETE /systems/1.json
  def destroy
    @system.destroy
    respond_to do |format|
      format.html { redirect_to systems_url, notice: 'System was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_params
      params.fetch(:system, {})
    end
end
