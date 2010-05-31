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

  def test_is_joel_test_find_last_score_of_user_should_return_nil
    assert_nil(JoelTestScore.find_last_score_of_user(0))
  end

  def test_is_joel_test_find_last_score_of_user_should_return_not_nil
    assert_not_nil(JoelTestScore.find_last_score_of_user(joel_test_scores(:joel_test_scores001).user_id))
  end

  def test_is_joel_test_find_last_score_by_user_should_return_not_nil
    assert_not_nil(JoelTestScore.find_last_score_by_user)
  end

  def test_is_joel_test_find_past_score_of_user_should_return_not_nil
    assert_not_nil(JoelTestScore.find_past_score_of_user(joel_test_scores(:joel_test_scores001).user_id))
  end

  def test_is_joel_test_find_last_score_of_user_should_equal_score
    assert_equal(joel_test_scores(:joel_test_scores003).score,   JoelTestScore.find_last_score_of_user(joel_test_scores(:joel_test_scores001).user_id).score)
  end

  def test_is_joel_test_find_last_score_of_user_should_equal_answers
    assert_equal(joel_test_scores(:joel_test_scores003).answers, JoelTestScore.find_last_score_of_user(joel_test_scores(:joel_test_scores001).user_id).answers)
  end

  def test_is_joel_test_find_last_score_by_user_should_equal
    assert_equal(2, JoelTestScore.find_last_score_by_user.length)
  end

  def test_is_joel_test_find_past_score_of_user_should_equal
    assert_equal(0, JoelTestScore.find_past_score_of_user(0).length)
  end
end
