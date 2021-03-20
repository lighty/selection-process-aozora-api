# == Schema Information
#
# Table name: works
#
#  id            :bigint           not null, primary key
#  file_url      :string           default(""), not null
#  name          :string           default(""), not null
#  pronunciation :string           default(""), not null
#  wikipedia_url :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  writer_id     :bigint           not null
#
# Indexes
#
#  index_works_on_writer_id  (writer_id)
#
FactoryBot.define do
  factory :work do
    name { 'こころ' }
    pronunciation { 'こころ' }
    file_url { 'https://www.aozora.gr.jp/cards/000148/files/773_ruby_5968.zip' }
    wikipedia_url { 'http://ja.wikipedia.org/wiki/%E3%81%93%E3%82%9D%E3%82%8D' }
    writer
  end
end
