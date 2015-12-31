require 'test_helper'

class GridFsFilesControllerTest < ActionController::TestCase
  setup do
    @grid_fs_file = grid_fs_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grid_fs_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grid_fs_file" do
    assert_difference('GridFsFile.count') do
      post :create, grid_fs_file: { author: @grid_fs_file.author, chunkSize: @grid_fs_file.chunkSize, contentType: @grid_fs_file.contentType, contents: @grid_fs_file.contents, filename: @grid_fs_file.filename, length: @grid_fs_file.length, md5: @grid_fs_file.md5, topic: @grid_fs_file.topic, uploadDate: @grid_fs_file.uploadDate }
    end

    assert_redirected_to grid_fs_file_path(assigns(:grid_fs_file))
  end

  test "should show grid_fs_file" do
    get :show, id: @grid_fs_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grid_fs_file
    assert_response :success
  end

  test "should update grid_fs_file" do
    patch :update, id: @grid_fs_file, grid_fs_file: { author: @grid_fs_file.author, chunkSize: @grid_fs_file.chunkSize, contentType: @grid_fs_file.contentType, contents: @grid_fs_file.contents, filename: @grid_fs_file.filename, length: @grid_fs_file.length, md5: @grid_fs_file.md5, topic: @grid_fs_file.topic, uploadDate: @grid_fs_file.uploadDate }
    assert_redirected_to grid_fs_file_path(assigns(:grid_fs_file))
  end

  test "should destroy grid_fs_file" do
    assert_difference('GridFsFile.count', -1) do
      delete :destroy, id: @grid_fs_file
    end

    assert_redirected_to grid_fs_files_path
  end
end
