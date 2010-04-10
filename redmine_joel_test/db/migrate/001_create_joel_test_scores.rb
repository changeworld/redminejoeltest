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
