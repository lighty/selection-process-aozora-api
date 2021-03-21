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
class WorkSerializer < ActiveModel::Serializer
  attributes :name, :pronunciation, :writer_name, :file_url, :wikipedia_url

  def writer_name
    object.writer.name
  end
end
