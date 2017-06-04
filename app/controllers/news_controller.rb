class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    @news = New.where("show_flag = true").paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    if request.post?
      @keyword = params[:keyword];@from = params[:from]; @to = params[:to]
      conn = [['1 = 1']]
      if @keyword.present?
        # conn[0] << 'title like ?'
        # conn << "%#{@keyword.to_s.strip}%"
        conn[0] << 'content like ? or title like ?'
        conn << "%#{@keyword.to_s.strip}%"
        conn << "%#{@keyword.to_s.strip}%"
      end
      if @from.present?
        conn[0] << 'show_time_from <= ?'
        conn << @from
      end
      if @to.present?
        conn[0] << 'show_time_to >= ?'
        conn << @to
      end
      conn[0] = conn[0].join(' and ')
      @news = New.where(conn).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = New.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = New.new(news_params)
    p "|"
    att = params[:content].to_s
    @news.content = att.gsub("</p>","").gsub("<p>","")
    @news.url = params[:f_url]+params[:l_url]
    respond_to do |format|
      if @news.save
        if params[:file_test].present?
          real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/
          new_image = NewImage.new
          new_image.owner_id = @news.id #这个不能去掉
          new_image.file_name = file_name
          new_image.file_path = real_path
          new_image.save
        end
        format.html { redirect_to @news, notice: 'New was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    att = params[:content].to_s.gsub("</p>","").gsub("<p>","")
    if att.present?
      @news.content = att
    end
    @news.url = params[:f_url]+params[:l_url]
    respond_to do |format|
      if @news.update(news_params)
        if params[:file_test].present?
          real_path, file_name = Attachment.upload(params[:file_test])#real_path = /upload_images/
          new_image = NewImage.new
          new_image.owner_id = @news.id #这个不能去掉
          new_image.file_name = file_name
          new_image.file_path = real_path
          new_image.save
        end
        format.html { redirect_to @news, notice: 'New was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to "/news", notice: 'New was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = New.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      # params.fetch(:news, {})
      params.require(:new).permit(:new_date,:show_time_from,:show_time_to,:title,:show_flag,:content,:f_url,:l_url)
    end
end
