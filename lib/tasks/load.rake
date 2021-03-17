class WriterPage
  def initialize(page)
    @page = page
  end

  def born_at
    text = page.search('td').select{ |td| td.text == '生年：' }.first&.next&.text
    return
    Date.new(*text.gsub(/ /, '').split('-').map(&:to_i)) # 空白入ってるやつやYYYY, YYYY-mmのやつらのため
  end

  def dead_at
    text = page.search('td').select{ |td| td.text == '没年：' }.first&.next&.text
    return
    Date.new(*text.gsub(/ /, '').split('-').map(&:to_i)) # 空白入ってるやつやYYYY, YYYY-mmのやつらのため
  end

  private
  attr :page
end

namespace :load do
  desc "作家情報の取得"
  task writer: :environment do
    agent = Mechanize.new
    agent.get('https://www.aozora.gr.jp/index_pages/person_all.html') do |page|
      writer_page_links = page.links.select{|l| l.href&.match(/person\d+.html/)}
      writer_page_links.each do |writer_page_link|
        writer_page = writer_page_link.click

        begin
          writer_page_obj = WriterPage.new(writer_page)
          w = Writer.new
          w.id            = writer_page.uri.to_s.match(/person(\d+).html/)[1].to_i
          w.name          = writer_page.search('td').select{ |td| td.text == '作家名：' }.first.next.text || ""
          w.pronunciation = writer_page.search('td').select{ |td| td.text == '作家名読み：' }.first.next.text || ""
          w.romaji        = writer_page.search('td').select{ |td| td.text == 'ローマ字表記：' }.first.next.text || ""
          w.born_at       = writer_page_obj.born_at
          w.dead_at       = writer_page_obj.dead_at
          w.summary       = writer_page.search('td').select{ |td| td.text == '人物について：' }.first&.next&.text || ""
          w.wikipedia_url = writer_page.search('td').select{ |td| td.text == '人物について：' }.first&.next&.search('a[2]')&.attribute('href')&.value || ""
          w.save! unless Writer.find_by_id(w.id)
        rescue => e
          pp w
          pp writer_page.search('/html/body/table/tr[4]/td[2]').text
          raise e
        end
      end
    end
  end
end
