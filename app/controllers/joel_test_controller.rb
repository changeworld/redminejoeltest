# Joel Test plugin for Redmine
# Copyright (C) 2010  Takashi Takebayashi
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
class JoelTestController < ApplicationController
  # A copy of ApplicationController has been removed from the module tree but is still active!対策
  unloadable
  # アクションが呼ばれる前に呼ぶメソッド
  before_filter :find_project, :find_user, :authorize

  # ジョエルテストの設問を表示する。
  # 既に回答している場合、前回の得点、直近5件までの回答結果を取得して表示する。
  def index
    @target = JoelTestScore.find_last_score_of_user @user.id
    find_average
    @permisson_answer_joel_test = @user.allowed_to?({:controller => :joel_test, :action => :answer}, @project, :global => :global)

    # ジョエルテストの設問の定数
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
    @reports = JoelTestScore.find_past_score_of_user @user.id
    @graph = JoelTestScore.sort_in_reverse @reports
  end

  # ジョエルテストの設問への回答を取得し、Yesの数(スコア)を格納する。
  def answer
    @joel_test_scores = JoelTestScore.new
    if (params[:question] == nil)
      # 未選択 = 0点
      @joel_test_scores.score = 0
      @joel_test_scores.answers = 0
    else
      @answer_values = params[:question].values.find_all {|val|
        val == 'yes'
      }
      @joel_test_scores.score = @answer_values != nil ? @answer_values.length : 0
      answers = 0
      for index in 0 .. 11
        answers = answers * 2 + (params[:question][(12 - index).to_s] != nil ?  params[:question][(12 - index).to_s] != 'no' ? 1: 0 : 0)
      end
      @joel_test_scores.answers = answers
    end
    @joel_test_scores.user_id = @user.id
    # @targetに値を入れてsaveを呼ぶとテーブルに値が格納される。
    @joel_test_scores.save
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

  # ユーザID毎の前回の得点を検索し、平均点と各設問へのYes回答率を算出する。
  def find_average
    @targets = JoelTestScore.find_last_score_by_user
    total_count = 0
    total_score = 0
    answers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @average_answers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    unless (@targets.length == 0)
      @targets.each {|target|
        total_count += 1
        user = JoelTestScore.find_last_score_of_user(target.user_id)
        total_score += user.score
        for index in 0 .. 11
          answers[index] += user.answers.to_i[index]
        end
      }
      @average_score = total_score.to_f / total_count
      for index in 0 .. 11
        @average_answers[index] = (answers[index].to_f / total_count) * 100
      end
    end
  end
end
