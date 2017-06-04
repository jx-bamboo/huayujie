class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.paginate(:page => params[:page],:per_page => APP_CONFIG[:per_page])
    if request.post?
      @admin = params[:admin]; @from = params[:from]; @to = params[:to]
      conn = [['1 = 1']]
      if @admin.present?
        conn[0] << 'admins.name like ?'
        conn << "%#{@admin.to_s.strip}%"
      end
      if @from.present? || @to.present?
        conn[0] << 'messages.start_time >= ?'
        conn << @from
      end
      if @to.present? && @from.blank?
        conn[0] << 'messages.start_time <= ?'
        conn << @to
      end
      conn[0] = conn[0].join(' and ')
      @messages = Message.joins("inner join admins on admins.id = messages.admin_id ").where(conn).paginate(:page => params[:page],:per_page => APP_CONFIG[:per_page])

    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @msg_update = MessageUpdateRecord.all.order("update_date desc").paginate(:page => params[:page],:per_page => 4)
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.admin_id = session[:admin]["id"]
    att = params[:content].to_s
    @message.content = att.gsub("</p>","").gsub("<p>","")
    if params[:checkobj] == "person"
      @message.send_object = params[:send_object]
    else
      @message.send_object = 0
    end
    respond_to do |format|
      if @message.save
        @msg_upt = MessageUpdateRecord.new
        @msg_upt.admin_id = session[:admin]["id"]
        @msg_upt.update_date = Time.now
        @msg_upt.update_type = "新建"
        @msg_upt.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    if params[:content].present?
      att = params[:content].to_s
      @message.content = att.gsub("</p>","").gsub("<p>","")
    end
    if params[:checkobj] == "person"
      @message.send_object = params[:send_object]
    else
      @message.send_object = 0
    end
    respond_to do |format|
      if @message.update(message_params)
        @msg_upt = MessageUpdateRecord.new
        @msg_upt.admin_id = session[:admin]["id"]
        @msg_upt.update_date = Time.now
        @msg_upt.update_type = "編輯"
        @msg_upt.save
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_select
    @user_select = User.paginate(:page => params[:page],:per_page=>APP_CONFIG[:per_page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      # params.fetch(:message, {})
      params.require(:message).permit(:user_id,:title,:content,:start_time,:send_object)
    end
end
