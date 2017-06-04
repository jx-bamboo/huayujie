class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  # layout nil?,:only => [:login,:logout]

  def login
    pp "1"
    if request.post?
      pp admin = params[:admin]
      admins = Admin.where("login = ? and password = ? and deleted_at is null",admin["login"],admin["password"]).first
      if admins.present?
        session[:admin] = admins
        redirect_to "/shops"
      else
        @login = params[:admin]["login"];@pwd = params[:admin]["password"]
        if @login.blank? || @pwd.blank?
          flash[:error]='用戶名或密碼不能為空。'
        else
          flash[:error]='用戶名或密碼不正確。'
        end
        return
      end
    end
  end

  def logout
    session.delete(:admin)
    redirect_to "/admins/login"
  end



  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.paginate(:page => params[:page],:per_page => APP_CONFIG[:per_page])
    if request.post?
      @login = params[:login];@name = params[:name];@email = params[:email]
      conn = [['1 = 1']]
      if @login.present?
        conn[0] << 'admins.login like ?'
        conn << "%#{@login.to_s.strip}%"
      end
      if @name.present?
        conn[0] << 'admins.name like ?'
        conn << "%#{@name.to_s.strip}%"
      end
      if @email.present?
        conn[0] << 'admins.email like ?'
        conn << "%#{@email.to_s.strip}%"
      end
      conn[0] = conn[0].join(' and ')
      @admins = Admin.where(conn).paginate(:page => params[:page],:per_page => APP_CONFIG[:per_page])
    end
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_url, notice: 'Admin was successfully created.' }
        # format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admins_url, notice: 'Admin was successfully updated.' }
        # format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      # params.fetch(:admin, {})
      params.require(:admin).permit(:login,:name,:password,:password_confirmation,:email,:phone)
    end
end
