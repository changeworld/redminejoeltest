class JoelTestController < ApplicationController
  # A copy of ApplicationController has been removed from the module tree but is still active!対策
  unloadable
  # アクションが呼ばれる前に呼ぶメソッド
  before_filter :find_project, :find_user

  # ジョエルテストの設問と回答している場合は、前回の得点を表示する。
  def index
    find_last_answer
    find_average_score
    # ジョエルテストの質問の定数
    @question_of_joel_test = [:text_do_you_use_source_control,
      :text_can_you_make_a_build_in_one_step,
      :text_do_you_make_daily_builds,
      :text_do_you_have_a_bug_database,
      :text_do_you_fix_bugs_before_writing_new_code,
      :text_do_you_have_an_up_to_date_schedule,
      :text_do_you_have_a_spec,
      :text_do_programmers_have_quiet_working_conditions,
      :text_do_you_use_the_best_tools_money_can_buy,
      :text_do_you_have_testers,
      :text_do_new_candidates_write_code_during_their_interview,
      :text_do_you_do_hallway_usability_testing
      ]
  end

  # ジョエルテストの設問への回答を取得し、Yesの数(スコア)を格納する。
  def reply
    @target = JoelTestScore.new
    if (params[:question] == nil)
      # 未選択 = 0点
      @target.score = 0
    else
      @answer_values = params[:question].values.find_all {|val|
        val == "yes"
      }
      @target.score = @answer_values != nil ? @answer_values.length : 0
    end
    @target.user_id = @user.id
    # @targetに値を入れてsaveを呼ぶとテーブルに値が格納される。
    @target.save
    redirect_to :action => 'index', :id => @project
  end

  private
  # プロジェクト情報を取得する。
  # タブ消滅対策
  def find_project
    @project = Project.find(params[:id])
  end

  # ユーザ情報を取得する。
  def find_user
    @user = User.current
  end

  # ユーザIDをキーにテーブルを検索する。
  def find_last_answer
    @target = JoelTestScore.find_last_score_of_user(@user.id)
  end

  # ユーザID毎の前回の得点を検索する。
  def find_average_score
    @all_target = JoelTestScore.find_last_score_by_user
    total_count = 0
    total_score = 0
    unless (@all_target.length == 0)
      @all_target.each {|target|
        total_count += 1
        total_score += target.score
      }
      @average_score = total_score / total_count
    end
  end
end
