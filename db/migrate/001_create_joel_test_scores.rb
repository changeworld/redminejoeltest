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
class CreateJoelTestScores < ActiveRecord::Migration
  def self.up
    create_table :joel_test_scores do |t|
      # user_idはRedmineのユーザID
      t.column :user_id,    :integer,   :default => 0,  :null => false
      # scoreはジョエルテストのスコア
      t.column :score,      :integer,   :default => 0,  :null => false
      # created_onはジョエルテストの登録日
      t.column :created_on, :datetime,                  :null => false
    end
  end

  def self.down
    drop_table :joel_test_scores
  end
end
