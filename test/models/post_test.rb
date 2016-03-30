require 'test_helper'

class PostTest < ActiveSupport::TestCase

	test 'validations' do
		post = Post.new(title: nil, content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus blandit odio ac diam euismod, in cursus mi auctor.')
		assert !post.save, 'Should NOT save'
		assert_equal(true, post.errors.messages[:title].include?('can\'t be blank'))

		post = Post.new(title: ' ', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus blandit odio ac diam euismod, in cursus mi auctor.')
		assert !post.save, 'Should NOT save'
		assert_equal(true, post.errors.messages[:title].include?('can\'t be blank'))

		post = Post.new(title: 'a'*257, content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus blandit odio ac diam euismod, in cursus mi auctor.')
		assert !post.save, 'Should NOT save'
		assert_equal(true, post.errors.messages[:title].include?('is too long (maximum is 255 characters)'))

		post = Post.new(title: 'Testt', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus blandit odio ac diam euismod, in cursus mi auctor.')
		post_dup = Post.new(title: 'Testt', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus blandit odio ac diam euismod, in cursus mi auctor.')
		assert post.save, 'Should save'
		assert !post_dup.save, 'Should NOT save'
		assert_equal(true, post_dup.errors.messages[:title].include?('has already been taken'))



		post = Post.new(title: 'My Title', content: nil)
		assert !post.save, 'Should NOT save'
		assert_equal(true, post.errors.messages[:content].include?('can\'t be blank'))

		post = Post.new(title: 'My Title', content: ' ')
		assert !post.save, 'Should NOT save'
		assert_equal(true, post.errors.messages[:content].include?('can\'t be blank'))

		post = Post.new(title: 'My Title', content: 'a'*257)
		assert !post.save, 'Should NOT save'
		assert_equal(true, post.errors.messages[:content].include?('is too long (maximum is 255 characters)'))

	end
end
