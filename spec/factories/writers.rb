# == Schema Information
#
# Table name: writers
#
#  id            :bigint           not null, primary key
#  born_at       :date
#  dead_at       :date
#  name          :string           default(""), not null
#  pronunciation :string           default(""), not null
#  romaji        :string           default(""), not null
#  summary       :string           default(""), not null
#  wikipedia_url :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :writer do
    born_at { '1867-02-09' }
    dead_at { '1916-12-09' }
    name { '夏目 漱石' }
    pronunciation { 'なつめ そうせき' }
    summary { '慶応3年1月5日（新暦2月9日）江戸牛込馬場下横町に生まれる。' }
    wikipedia_url { 'http://ja.wikipedia.org/' }

    trait :with_work do
      after :build do |writer|
        writer.works << build(:work) 
      end
    end
  end
end
