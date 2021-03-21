class WorkSerializer < ActiveModel::Serializer
  attributes :name, :pronunciation, :writer_name, :file_url, :wikipedia_url

  def writer_name
    object.writer.name
  end
end
