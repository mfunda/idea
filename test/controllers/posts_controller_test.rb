require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    @admin = users(:one)
    @user = users(:two)
  end

  teardown do
    sign_out @user
    sign_out @admin
  end

  test "should get index" do
    sign_in @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should NOT get index" do
    get :index
    assert_redirected_to new_user_session_path
    sign_in @user
    get :index
    assert_response :unauthorized
  end

  test "should get new" do
    sign_in @admin
    get :new
    assert_response :success
  end

  test "should NOT get new" do
    get :new
    assert_redirected_to new_user_session_path
    sign_in @user
    get :new
    assert_response :unauthorized  
  end

  test "should create post" do
    sign_in @admin
    assert_difference('Post.count') do
      post :create, post: { title: 'Test Title', content: 'Test content' }
    end
    assert_redirected_to post_path(assigns(:post))
    assert_equal('Test Title', Post.last.title)
    assert_equal('Test content', Post.last.content)
  end

  test "should NOT create post" do
    assert_difference('Post.count', 0) do
      post :create, post: { title: 'Test Title', content: 'Test content' }
    end
    assert_redirected_to new_user_session_path
    sign_in @user
    post :create, post: { title: 'Test Title', content: 'Test content' }
    assert_response :unauthorized  
  end

  test "should show post" do
    sign_in @admin
    get :show, id: @post
    assert_response :success
  end

  test "should NOT show post" do
    get :show, id: @post
    assert_redirected_to new_user_session_path
    sign_in @user
    get :show, id: @post
    assert_response :unauthorized
  end

  test "should get edit" do
    sign_in @admin
    get :edit, id: @post
    assert_response :success
  end

  test "should NOT get edit" do
    get :edit, id: @post
    assert_redirected_to new_user_session_path
    sign_in @user
    get :edit, id: @post
    assert_response :unauthorized
  end

  test "should update post" do
    sign_in @admin
    patch :update, id: @post, post:  { title: 'This is example title', content: 'Test content' }
    assert_redirected_to post_path(assigns(:post))
    assert_equal('This is example title', Post.find(@post.id).title)
    assert_equal('Test content', Post.find(@post.id).content)
  end

  test "should NOT update post" do
    patch :update, id: @post, post:  { title: 'This is example', content: 'Test content test test' }
    assert_redirected_to new_user_session_path
    sign_in @user
    patch :update, id: @post, post:  { title: 'This is example', content: 'Test content test test' }
    assert_response :unauthorized
  end

  test "should destroy post" do
    sign_in @admin
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end

  test "should NOT destroy post" do
    assert_difference('Post.count', 0) do
      delete :destroy, id: @post
    end
    assert_redirected_to new_user_session_path
    sign_in @user
    delete :destroy, id: @post
    assert_response :unauthorized
  end
end
