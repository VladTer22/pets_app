class ModifyTopics < ActiveRecord::Migration[6.0]
  def change
    add_index :topics, :alias, unique: true
    Topic.create :alias =>"dogs", :title => "Dogs"
    Topic.create :alias => "cats", :title => "Cats"
    Topic.create :alias => "hamsters", :title => "Hamsters"
    Topic.create :alias => "parrots", :title => "Parrots"
    Topic.create :alias => "minotaurs", :title => "Minotaurs"
  end
end