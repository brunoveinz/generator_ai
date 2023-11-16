require "test_helper"

class FotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @foto = fotos(:one)
  end

  test "should get index" do
    get fotos_url
    assert_response :success
  end

  test "should get new" do
    get new_foto_url
    assert_response :success
  end

  test "should create foto" do
    assert_difference("Foto.count") do
      post fotos_url, params: { foto: { body: @foto.body, title: @foto.title } }
    end

    assert_redirected_to foto_url(Foto.last)
  end

  test "should show foto" do
    get foto_url(@foto)
    assert_response :success
  end

  test "should get edit" do
    get edit_foto_url(@foto)
    assert_response :success
  end

  test "should update foto" do
    patch foto_url(@foto), params: { foto: { body: @foto.body, title: @foto.title } }
    assert_redirected_to foto_url(@foto)
  end

  test "should destroy foto" do
    assert_difference("Foto.count", -1) do
      delete foto_url(@foto)
    end

    assert_redirected_to fotos_url
  end
end
