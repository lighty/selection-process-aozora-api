namespace :load do
  desc "作家情報の取得"
  task writer: :environment do
    agent = Mechanize.new
    agent.get('https://www.aozora.gr.jp/index_pages/person_all.html') do |page|
      writer_page_links = page.links.select{|l| l.href&.match(/person\d+.html/)}
      writer_page_links.each do |writer_page_link|
        writer = PageAdaptor::WriterPage.new(writer_page_link.click).to_model
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
          PageAdaptor::WorkPage.new(work_link.click).to_hash
        end
        Work.insert_all(works)
      end
    end
  end
end
