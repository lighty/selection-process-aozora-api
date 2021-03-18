class WriterPage
  def initialize(page)
    @page = page
  end

  def id() = page.uri.to_s.match(/person(\d+).html/)[1].to_i
  def name() = search_value_of('作家名：')
  def pronunciation() = search_value_of('作家名読み：')
  def romaji() = search_value_of('ローマ字表記：')
  def summary() = search_value_of('人物について：')

  def born_at
    text = search_value_of('生年：')
    return if text.blank?
    text.gsub!(/ /, '') # 空白入ってるやつ
    text.gsub!(/--/, '-') # ハイフン連続しちゃってるやつ
    Date.new(*text.split('-').map(&:to_i)) # YYYY, YYYY-mmの形式のやつ
  end

  def dead_at
    text = search_value_of('没年：')
    return if text.blank?
    text.gsub!(/ /, '') # 空白入ってるやつ
    text.gsub!(/--/, '-') # ハイフン連続しちゃってるやつ
    Date.new(*text.split('-').map(&:to_i)) # YYYY, YYYY-mmの形式のやつ
  end

  def wikipedia_url
    page.search('td').select{ |td| td.text == '人物について：' }.first&.next&.search('a[2]')&.attribute('href')&.value || ""
  end

  def to_model
    Writer.new(id: id, name: name, pronunciation: pronunciation, romaji: romaji,
               born_at: born_at, dead_at: dead_at, summary: summary, wikipedia_url: wikipedia_url)
  end

  private

  def search_value_of(header)
    page.search('td').select{ |td| td.text == header }.first&.next&.text || ""
  end

  attr :page
end

namespace :load do
  desc "作家情報の取得"
  task writer: :environment do
    agent = Mechanize.new
    agent.get('https://www.aozora.gr.jp/index_pages/person_all.html') do |page|
      writer_page_links = page.links.select{|l| l.href&.match(/person\d+.html/)}
      writer_page_links.each do |writer_page_link|
        writer = WriterPage.new(writer_page_link.click).to_model
        writer.save! unless Writer.find_by_id(writer.id)
      end
    end
  end
end
