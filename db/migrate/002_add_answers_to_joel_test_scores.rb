class AddAnswersToJoelTestScores < ActiveRecord::Migration
  def self.up
    add_column(:joel_test_scores,     :answers, :integer, :default => 0,  :null => false)
  end

  def self.down
    remove_column(:joel_test_scores,  :answers)
  end
end
