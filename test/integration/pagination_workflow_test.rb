require 'test_helper'
require 'application_system_test_case'

class PaginationWorkflowTest < ApplicationSystemTestCase 
  def setup
    @topic_dogs = create(:topic, :dogs)
    @topic_cats = create(:topic, :cats)
    @topic_hamsters = create(:topic, :hamsters)
    @topic_parrots = create(:topic, :parrots)
    @topic_minotaurs = create(:topic, :minotaurs)

    @post_dogs = create_list(:post, 4, :about_dogs, topic: @topic_dogs)[0]
    @post_cats = create_list(:post, 4, :about_cats, topic: @topic_cats)[0]
    @post_hamsters = create_list(:post, 4, :about_hamsters, topic: @topic_hamsters)[0]
    @post_parrots = create_list(:post, 4, :about_parrots, topic: @topic_parrots)[0]
    @post_minotaurs = create_list(:post, 4, :about_minotaurs, topic: @topic_minotaurs)[0]
  end

  test 'index pagination' do
    visit "/"
    page.has_css?("card-body", count: 3)
    page.has_content?(@post_minotaurs.title, count: 3)

    click_on "Oldest"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_minotaurs.title, count: 1)
    page.has_content?(@post_parrots.title, count: 2)

    click_on "Oldest"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_parrots.title, count: 2)
    page.has_content?(@post_hamsters.title, count: 1)

    click_on "Oldest"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_hamsters.title, count: 3)

    click_on "Oldest"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_dogs.title, count: 3)

    click_on "Oldest"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_dogs.title, count: 1)
    page.has_content?(@post_cats.title, count: 2)

    click_on "Oldest"

    page.has_css?("card-body", count: 2)
    page.has_content?(@post_cats.title, count: 2)

    click_on "Newest"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_dogs.title, count: 1)
    page.has_content?(@post_cats.title, count: 2)

    click_on "Newest"
    click_on "Newest"
    click_on "Newest"
    click_on "Newest"
    page.has_css?("card-body", count: 3)
    page.has_content?(@post_minotaurs.title, count: 3)
  end

  test 'topic pagination' do
    topics = [
      {
        "path" => "/posts/dogs",
        "post" => @post_dogs
      },
      {
        "path" => "/posts/cats",
        "post" => @post_cats
      },
      {
        "path" => "/posts/hamsters",
        "post" => @post_hamsters
      },
      {
        "path" => "/posts/parrots",
        "post" => @post_parrots
      },
      {
        "path" => "/posts/minotaurs",
        "page_title" => "Minotaurs!",
        "post" => @post_minotaurs
      }
    ]

    topics.each do |topic_data|
      visit topic_data["path"]
      page.has_content?(topic_data["post"].title, count: 3)
      click_on "Oldest"
      page.has_content?(topic_data["post"].title, count: 1)
      click_on "Newest"
      page.has_content?(topic_data["post"].title, count: 3)
    end
  end
end