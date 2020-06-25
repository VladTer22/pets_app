require 'test_helper'
require 'application_system_test_case'

class TopicWorkflowTest < ApplicationSystemTestCase 
  def setup
    @post_dogs = create(:post, :about_dogs)
    @post_cats = create(:post, :about_cats)
    @post_hamsters = create(:post, :about_hamsters)
    @post_parrots = create(:post, :about_parrots)
    @post_minotaurs = create(:post, :about_minotaurs)
  end

  test 'topic pages' do
    topics = [
      {
        "path" => "/posts/dogs",
        "page_title" => "Dogs",
        "post" => @post_dogs
      },
      {
        "path" => "/posts/cats",
        "page_title" => "Cats",
        "post" => @post_cats
      },
      {
        "path" => "/posts/hamsters",
        "page_title" => "Hamsters",
        "post" => @post_hamsters
      },
      {
        "path" => "/posts/parrots",
        "page_title" => "Parrots",
        "post" => @post_parrots
      },
      {
        "path" => "/posts/minotaurs",
        "page_title" => "Minotaurs",
        "post" => @post_minotaurs
      }
    ]

    topics.each do |topic_data|
      visit topic_data["path"]
      page.has_content?(topic_data["page_title"])
      page.has_content?(topic_data["post"].title)
      page.has_content?(topic_data["post"].body)
    end
  end
end