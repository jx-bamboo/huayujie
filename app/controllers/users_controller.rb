class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    if request.post?
      @login = params[:login];@name = params[:name];@email = params[:email];@phone = params[:phone];@sex = params[:sex]
      conn = [['1 = 1']]
      if @login.present?
        conn[0] << 'users.login like ?'
        conn << "%#{@login.to_s.strip}%"
      end
      if @name.present?
        conn[0] << 'users.name like ?'
        conn << "%#{@name.to_s.strip}%"
      end
      if @email.present?
        conn[0] << 'users.email like ?'
        conn << "%#{@email.to_s.strip}%"
      end
      if @phone.present?
        conn[0] << 'users.phone like ?'
        conn << "%#{@phone.to_s.strip}%"
      end
      if @sex.present?
        conn[0] << 'users.sex = ?'
        conn << @sex
      end
      conn[0] = conn[0].join(' and ')
      @users = User.where(conn).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    birth = "2016"+"-"+params[:month]+"-"+params[:day]
    @user.age_segment = params[:age_segment]
    @user.birthday = birth
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    birth = "2016"+"-"+params[:month]+"-"+params[:day]
    @user.age_segment = params[:age_segment]
    @user.birthday = birth
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # params.fetch(:user, {})
      params.require(:user).permit(:login,:name,:email,:password,:password_confirmation,:phone,:sex,:birthday,:profession,:age_segment,:recommend_person_phone)
    end
end
