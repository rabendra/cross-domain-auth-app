# == Schema Information
#
# Table name: horses
#
#  id                 :integer          not null, primary key
#  person_id          :integer
#  name               :string(255)
#  age                :integer
#  competes_in        :string(255)
#  breed              :string(255)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class HorseSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :age,
              :competition_type,
              :breed,
              :photo,
              :user
  def user
    UserSerializer.new(object.user, root: false)
  end
end
