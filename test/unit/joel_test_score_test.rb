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
require File.dirname(__FILE__) + '/../test_helper'

class JoelTestScoreTest < ActiveSupport::TestCase
  fixtures :joel_test_scores

  def test_is_joel_test_scores_should_return_nil
    assert_nil(JoelTestScore.find_last_score_of_user(0))
  end

  def test_is_joel_test_scores_should_return_not_nil
    assert_not_nil(JoelTestScore.find_last_score_of_user(1))
    assert_not_nil(JoelTestScore.find_last_score_by_user)
  end

  def test_is_joel_test_scores_should_equal
    user1 = JoelTestScore.find_last_score_of_user(1)
    assert_equal(1, user.user_id)
    assert_equal(3, user.score)
    users = JoelTestScore.find_last_score_by_user
    unless (all_user.length == 0)
      all_user.each do |user|
        assert_equal(1, user.user_id)
        assert_equal(3, user.score)
      end
    end
  end
end
