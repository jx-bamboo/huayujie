require 'yaml'

# もしキーが存在しなかったら例外を投げる様にする。
APP_CONFIG = Hash.new{|hash, key| raise(IndexError, "no such key : [#{key}] !!")}
APP_CONFIG.merge!(YAML.load(File.open(Rails.root.to_s + '/config/app_config.yml')))
APP_CONFIG.each do |k,v|
  if v.is_a?(Hash)
    v.replace(Hash.new{|hash,key| raise(IndexError, "no such a key in APP_CONFIG : #{key} !!")}.merge(v))
  end
end

APP_CONFIG[:email_regexp] = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

# APP_CONFIGのキーが全てSymbolで指定してあるかチェック
# Symbol以外の値は不正なので、例外を出して起動を中止する。
def app_config_valid?(hash)
  hash.each do |k,v|
    unless k.is_a?(Symbol)
      # Railsの仕様で、environment.rb で例外を出しても起動してしまうが、
      # gem の読み込みエラーのみ停止してくれるので、仕方なくそれを利用する。
      # 詳細は config/boot.rb を参照のこと。
      require "/config/app_config.yml"# のキーは全てシンボルでなければいけません。'
    end

    case 
    when v.is_a?(Hash)   # Hashならば、再帰処理
      app_config_valid?(v)
    when v.is_a?(String) # Stringならば、{Rails.root.to_s}を実際の値に書き換える.
      v.sub!(/\{Rails.root.to_s\}/, Rails.root.to_s)
    end
  end
end
app_config_valid?(APP_CONFIG)

# Don't Comment out!!
APP_CONFIG.freeze
