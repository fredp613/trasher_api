require 'test_helper'

class TrashImagesControllerTest < ActionController::TestCase
  setup do
    @trash_image = trash_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trash_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trash_image" do
    assert_difference('TrashImage.count') do
      post :create, trash_image: { trash_id: @trash_image.trash_id, trash_image: @trash_image.trash_image }
    end

    assert_redirected_to trash_image_path(assigns(:trash_image))
  end

  test "should show trash_image" do
    get :show, id: @trash_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trash_image
    assert_response :success
  end

  test "should update trash_image" do
    patch :update, id: @trash_image, trash_image: { trash_id: @trash_image.trash_id, trash_image: @trash_image.trash_image }
    assert_redirected_to trash_image_path(assigns(:trash_image))
  end

  test "should destroy trash_image" do
    assert_difference('TrashImage.count', -1) do
      delete :destroy, id: @trash_image
    end

    assert_redirected_to trash_images_path
  end
end
