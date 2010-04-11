class JoelTestScore < ActiveRecord::Base
  # テーブルの中から指定ユーザの前回の得点のインスタンスを探して返す。
  # 見つからなければ nil を返す。
  def self.find_last_score_of_user(user_id)
    find(:first, :conditions => ["user_id = (?)", user_id], :order => "created_on DESC")
  end

  # テーブルの中からユーザ毎に前回の得点のインスタンスを探して返す。
  # 見つからなければ空配列を返す。
  def self.find_last_score_by_user
    find(:all, :group => "user_id")
  end
end
