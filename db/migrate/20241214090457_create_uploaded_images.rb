class CreateUploadedImages < ActiveRecord::Migration[7.1]
  def change
    create_table :uploaded_images do |t|
      t.string :image

      t.timestamps
    end
  end
end
