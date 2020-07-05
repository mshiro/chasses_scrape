require_relative 'sierra/parse'
require_relative 'sierra/html_reader'
require_relative 'sierra/scraper'
require_relative 'sierra/json_wrter'

module Sierra
  def self.thermaltake(path,url)
    #基準ファイルの有無確認と全リンク取得
    Parse.thermaltake(path,url)
    #options = PreProcesser.exec(argv)
    #reader = HtmlReader.new(options)
    #writer = JsonWriter.new(options)
    #pitnews = Scraper.scrape(reader.read)
    #writer.write(pitnews)
  end

  def self.phanteks()

  end
end
