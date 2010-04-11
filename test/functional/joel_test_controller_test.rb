require File.dirname(__FILE__) + '/../test_helper'
require 'joel_test_controller'

class JoelTestControllerTest < ActionController::TestCase
  fixtures :attachments,
            :enabled_modules,
            :members,
            :member_roles,
            :projects,
            :roles,
            :users,
            :joel_test_scores

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller = JoelTestController.new
    @controller.request = @request
    Attachment.storage_path = "#{RAILS_ROOT}/test/fixtures/files"
    EnabledModule.generate!(:project_id => 1, :name => 'joel_test')

    roles = Role.find(:all)
    roles.each {|role|
      role.permissions << :index
      role.save
    }
    User.current = nil
  end

  def test_index
    # get リクエストでの index アクションの呼び出し。 id をパラメータとして渡す。
    @request.session[:user_id] = 1
    get :index, :id => 1
    # 呼び出した結果の正否の確認
    assert_response :success
    # クラス変数 @project が nil で無いことの確認
    assert_not_nil assigns(:project)
    # クラス変数 @user が nil で無いことの確認
    assert_not_nil assigns(:user)
    # クラス変数 @target が nil で無いことの確認
    assert_not_nil assigns(:target)
    # クラス変数 @average_score が nil で無いことの確認
    assert_not_nil assigns(:average_score)
    # クラス変数 @question_of_joel_test が nil で無いことの確認
    assert_not_nil assigns(:question_of_joel_test)
  end
end
