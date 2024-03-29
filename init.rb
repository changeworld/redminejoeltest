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
require 'redmine'

Redmine::Plugin.register :redmine_joel_test do
  name 'Redmine Joel Test plugin'
  author 'Takashi Takebayashi'
  url "http://www.r-labs.org/projects/show/joeltest" if respond_to?(:url)
  description 'This is a Joel Test plugin for Redmine'
  version '0.0.6'
  requires_redmine :version_or_higher => '0.9.0'

  project_module :joel_test do
    permission :view_joel_test, {:joel_test => [:index]}
    permission :answer_joel_test, {:joel_test => [:index, :answer]}, :require => :member
  end

  # プロジェクトメニューにジョエルテストプラグインを追加する設定
  menu :project_menu, :joel_test, {:controller => 'joel_test', :action => 'index'}, :caption => :joel_test
end
