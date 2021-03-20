# == Schema Information
#
# Table name: works
#
#  id            :integer          not null, primary key
#  file_url      :string           default(""), not null
#  name          :string           default(""), not null
#  pronunciation :string           default(""), not null
#  wikipedia_url :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  writer_id     :integer          not null
#
# Indexes
#
#  index_works_on_writer_id  (writer_id)
#
class Work < ApplicationRecord
  belongs_to :writer
end
