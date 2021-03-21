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
class WriterSerializer < ActiveModel::Serializer
  attributes :name, :pronunciation, :romaji, :born_at, :dead_at, :summary, :wikipedia_url, :works

  def works
    object.works.sort.pluck(:id)
  end
end
