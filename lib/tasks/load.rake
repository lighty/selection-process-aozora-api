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

class WorkPage
  def initialize(page)
    @page = page
  end

  def id() = page.uri.to_s.match(/card(\d+).html/)[1].to_i
  def name() = search_value_of('作品名：')
  def pronunciation() = search_value_of('作品名読み：')

  def writer_id
    page.uri.to_s.match(/\/(\d+)\//)[1].to_i
  end

  def wikipedia_url
    page.search('td').select{ |td| td.text == '作品について：' }.first&.next&.search('a[3]')&.attribute('href')&.value || ""
  end

  def file_url
    return '' if page.links.select{ |l| l.href&.match(/\.zip$/) }.size == 0
    page.uri.to_s.split('/')[0...-1].join('/') + page.links.select{ |l| l.href&.match(/\.zip$/) }.first.href[1..-1]
  end

  def to_model
    Work.new(to_hash)
  end

  def to_hash
    { id: id, name: name, pronunciation: pronunciation, file_url: file_url, wikipedia_url: wikipedia_url, writer_id: writer_id,
      created_at: Time.now, updated_at: Time.now }
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

  desc "作品情報の取得"
  task work: :environment do
    agent = Mechanize.new
    agent.get('https://www.aozora.gr.jp/index_pages/person_all.html') do |page|
      writer_page_links = page.links.select{|l| l.href&.match(/person\d+.html/)}
      writer_page_links.each do |writer_page_link|
        writer_page = writer_page_link.click
        work_links = writer_page.links.select{|l| l.href&.match(/card\d+.html/)}
        works = Parallel.map(work_links, in_thread: 10) do |work_link|
          WorkPage.new(work_link.click).to_hash
        end
        Work.insert_all(works)
      end
    end
  end
end
