json.array!(@grid_fs_files) do |grid_fs_file|
  json.extract! grid_fs_file, :id, :filename, :contentType, :author, :topic, :uploadDate, :length, :chunkSize, :md5
  json.url grid_fs_file_url(grid_fs_file, format: :json)
end
