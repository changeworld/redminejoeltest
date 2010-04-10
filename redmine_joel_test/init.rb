require 'redmine'

Redmine::Plugin.register :redmine_joel_test do
  name 'Redmine Joel Test plugin'
  author 'Takashi Takebayashi'
  description 'This is a Joel Test plugin for Redmine'
  version '0.0.2'
  requires_redmine :version_or_higher => '0.9.0'

  project_module :joel_test do
    permission :index, {:joel_test => [:index]}
  end

  # プロジェクトメニューにジョエルテストプラグインを追加する設定
  menu :project_menu, :joeltest, {:controller => 'joel_test', :action => 'index'}, :caption => :JoelTest
end
