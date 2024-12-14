# == Schema Information
#
# Table name: uploaded_images
#
#  id         :bigint           not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UploadedImage < ApplicationRecord
  mount_uploader :image, ImageUploader
end
