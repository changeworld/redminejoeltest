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
class JoelTestScore < ActiveRecord::Base
  # テーブルの中から指定ユーザの前回の得点のインスタンスを探して返す。
  # 見つからなければ nil を返す。
  def self.find_last_score_of_user(user_id)
    find(:first, :conditions => ["user_id = (?)", user_id], :order => "created_on DESC")
  end

  # テーブルの中からユーザ毎の得点のインスタンスを探して返す。
  # 見つからなければ空配列を返す。
  def self.find_last_score_by_user
    find(:all, :group => "user_id")
  end
end
