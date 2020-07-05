require 'net/http'
require 'nokogiri'
require 'fileutils'

module Sierra
  class Parse
    def self.thermaltake(path,url)
      file_exist(path,url)
      doc = nokogiri(path)
      (2..((doc.xpath('//span[@class = "toolbar-number"]')[2].text.to_f / 30).ceil)).each { |i|
        file_exist(path.sub(/[0-9]+/, i.to_s),url.chop<<i.to_s)
      }
    end
    def self.read_website(url)
      Net::HTTP.get(URI(url))
    end    
    def self.read_file(path)
      File.read(path)
    end
    def self.write_file(path, text)
      File.open(path, 'w') { |file| file.write(text) }
    end
    def self.file_exist(path,url)
      #ローカルにHTMLファイルが存在しない場合,取得する(存在するか?の真偽の逆)
      #ローカルのHTMLが取得後何日経過している場合,取得する
      write_file(path, read_website(url)) if !(File.exist?(path))
      write_file(path, read_website(url)) if 86400 < (Time.now - File::Stat.new(path).mtime)
      #現在時刻
      #p Time.now
      #pathの最終更新日時
      #p File::Stat.new(path).mtime
      #p "#{Time.now - File::Stat.new(path).mtime}秒"
    end
    def self.nokogiri(path)
      Nokogiri::HTML.parse(read_file(path), nil, 'utf-8')
    end

    def self.common(path,url)
      file_exist(path,url)
    end
  end
end
