class WriterSerializer < ActiveModel::Serializer
  attributes :name, :pronunciation, :romaji, :born_at, :dead_at, :summary, :wikipedia_url, :works

  def works
    object.works.sort.pluck(:id)
  end
end
