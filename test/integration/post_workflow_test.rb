require 'test_helper'
require 'application_system_test_case'

class PostWorkflowTest < ApplicationSystemTestCase
  def setup
    @post = create(:post, :about_dogs)
    create(:topic, :cats)
    create(:topic, :hamsters)
    create(:topic, :parrots)
    create(:topic, :minotaurs)
  end

  test 'post show' do
    visit "/posts/" + @post.id.to_s

    assert page.has_content?(@post.title)
    assert page.has_content?(@post.body)
  end

  test 'successful post create and edit' do
    # creating post
    visit "/posts/new"

    fill_in "Title", with: "About my humster"
    fill_in "Text",  with: "Hamster lifestory"
    select("Hamsters", from: "Choose theme")

    click_on "Create"

    post_id = Post.last.id.to_s
    assert_current_path "/posts/" + post_id
    assert page.has_content?("About my humster")
    assert page.has_content?("Hamster lifestory")

    # editing post
    visit "/posts/edit/" + post_id
    page.has_select?('post[topic]', selected: 'Hamsters')
    fill_in "Title", with: "About my minotaur"
    fill_in "Text",  with: "Minotaur lifestory"
    select("Minotaurs", from: "Choose theme")

    click_on "Save"
    assert_current_path "/posts/" + post_id
    assert page.has_content?("About my minotaur")
    assert page.has_content?("Minotaur lifestory")
    visit "/posts/edit/" + post_id
    page.has_select?('post[topic]', selected: 'Minotaurs')
  end

  test 'post create validation errors' do
    # creating post
    visit "/posts/new"

    fill_in "Title", with: ""
    fill_in "Text",  with: ""

    click_on "Create"

    assert page.has_content?("can't be blank")
    assert page.has_content?("can't be blank")

    fill_in "Title", with: "x" * 301

    click_on "Create"
    assert page.has_content?("is too long")
 end

  test 'post edit validation errors' do
    # editing post
    visit "/posts/edit/" + @post.id.to_s

    fill_in "Title", with: ""
    fill_in "Text", with: ""

    click_on "Save"

    assert page.has_content?("can't be blank")
    assert page.has_content?("can't be blank")

    fill_in "Title", with: "x" * 301

    click_on "Save"
    assert page.has_content?("is too long")
  end
end