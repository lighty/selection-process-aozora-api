class PageAdaptor::WorkPage
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
