class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :aws

  def store_dir
    "avatars"
  end

  process resize_to_fill: [300,300]

  version :thumbnail do
    process resize_to_fill: [50,50]
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, "avatar.png"].compact.join('_'))
  end

  def extension_white_list
    %w(jpg jpeg png)
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
