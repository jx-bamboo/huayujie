class Attachment < ApplicationRecord
  def self.image_preview(file)
    p "0"
    #获得预览图片的名字
    time = (DateTime.now).strftime("%Y%m%d").to_s
    sui = rand(100000).to_s

    file_name = time+"_"+sui+ File.extname(file.original_filename)

    # file_name = time+"_"+sui+ File.extname(file)

    p file_name,"*"

    #预览缓存的文件夹
    file_path = "#{Rails.root}/public/upload_images/temp_image/"
    p "11"
    #获得实际路径（文件路径+文件名）
    real_path = file_path + file_name
    p "22"
    #如果file_path（文件夹）不存在，则生成file_path（文件夹）
    FileUtils.mkdir_p(file_path) unless File.exist?(file_path)
    p "33"
    #删除存在的文件路径（FileUtils.rm_r(real_path)）
    File.delete(real_path) if File.exist?(real_path)
    #    File.rm_r Dir.glob(real_path) if File.exist?(real_path)
    p "44"
    #写入文件并读取
    File.open(file_path + file_name, "wb" ) do |f|
      p "55"
      f.write(file.read)
      # f.write(file)
    end
    p "66"
    return file_name
  end

  # 获得图片的url
  def self.get_image(name)
    pp name, "**************"
    "/upload_images/temp_image/#{name}"
  end

  # 上传图片
  #【引数】file上传的图片，type类名，id
  def self.upload(file)#可以传多个参数（file,type,id）,其中type为user|blog，id为user|blog的id。
    p 0
    if  file.present?#或者if id.present?&&type.present?&&file.present?

      begin
        time = (DateTime.now).strftime("%Y%m%d").to_s
        sui = rand(100000).to_s

        file_name = time+"_"+sui+ File.extname(file.original_filename)

        #实际根路径
        rails_root = "#{Rails.root}/public"

        #实际路径
        real_path = "/upload_images/"

        #文件路径（根路径+实际路径+文件夹名）
        file_path = rails_root + real_path + "original_image/"

        #创建文件夹（如果#{RAILS_ROOT}/public/upload_images/original_image/不存在）
        FileUtils.mkdir_p(file_path) unless File.exist?(file_path)
        if File.exist?(file_path + file_name)

          File.delete(file_path + file_name)
        end

        File.open(file_path + file_name, "wb" ) do |f|
          f.write(file.read)
        end
      rescue => e
        raise ActiveRecord::Rollback
      end
      return real_path, file_name
    end
  end
end
