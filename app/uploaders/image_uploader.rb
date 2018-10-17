# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  storage :fog

  def store_dir
    'category_images'
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, "math_book.png"].compact.join('_'))
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end
