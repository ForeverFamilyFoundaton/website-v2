require 'shrine'
require 'shrine/storage/file_system'
require "shrine/storage/s3"

s3_options = {
  bucket: Rails.application.credentials.aws[:s3_bucket_name],
  region: Rails.application.credentials.aws[:region],
  access_key_id: Rails.application.credentials.aws[:access_key_id],
  secret_access_key: Rails.application.credentials.aws[:secret_access_ke]
}

if Rails.env.production?
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'shrine/logos/cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'shrine/logos', **s3_options)
  }
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')        # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :pretty_location
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :derivatives
Shrine.plugin :determine_mime_type
