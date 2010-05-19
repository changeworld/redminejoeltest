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
desc 'Test Redmine Joel Test Plugin'
begin
  rcov_unit_options = "-I ../../../lib -x redmine"

  namespace :redmine_joel_test do
    namespace :test do
      task :unit => [:cd_plugin_dir, :environment, :init_fixtures] do
        desc 'Unit Test for Redmine Joel Test Plugin'
        system "rcov #{rcov_unit_options} test/unit/*_test.rb"
      end

      task :init_fixtures do
        desc "Init Fixtures"
        Rake::Task["test:plugins:setup_plugin_fixtures"].invoke
      end

      task :cd_plugin_dir do
        Dir.chdir("vendor/plugins/redmine_joel_test")
      end
    end
  end
rescue LoadError => e
  # rcov not available
  $stderr.print "redmine_joel_test:testing load error #{e}"
end
