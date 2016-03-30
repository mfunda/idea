require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
	test "validations" do 
		user = User.new({first_name: nil, last_name: 'Fundakowski', login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:first_name].include?('can\'t be blank'))

		user = User.new({first_name: ' ', last_name: 'Fundakowski', login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:first_name].include?('can\'t be blank'))

		user = User.new({first_name: 'a'*257, last_name: 'Fundakowski', login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:first_name].include?('is too long (maximum is 255 characters)'))



		user = User.new({first_name: 'Mateusz', last_name: nil, login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:last_name].include?('can\'t be blank'))

		user = User.new({first_name: 'Mateusz', last_name: ' ', login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:last_name].include?('can\'t be blank'))

		user = User.new({first_name: 'Mateusz', last_name: 'a'*257, login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:last_name].include?('is too long (maximum is 255 characters)'))



		user = User.new({first_name: 'Mateusz', last_name: 'Fundakowski', login: nil,  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:login].include?('can\'t be blank'))

		user = User.new({first_name: 'Mateusz', last_name: 'Fundakowski', login: ' ',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:login].include?('can\'t be blank'))

		user = User.new({first_name: 'Mateusz', last_name: 'Fundakowski', login: 'a'*257,  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save'
		assert_equal(true, user.errors.messages[:login].include?('is too long (maximum is 255 characters)'))


		
		user = User.new({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: nil, password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save!'
		assert_equal(true, user.errors.messages[:email].include?('can\'t be blank'))

		user = User.new({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: ' ', password: 'test12345', password_confirmation: 'test12345' })
		assert !user.save, 'Should NOT save!'
		assert_equal(true, user.errors.messages[:email].include?('can\'t be blank'))

		user = User.new({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: 'a'*257, password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save!'
		assert_equal(true, user.errors.messages[:email].include?('is too long (maximum is 255 characters)'))

		user = User.new({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: 'TeST+example.com', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save!'
		assert_equal(true, user.errors.messages[:email].include?('is invalid'))

		user = User.new({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: 'TeSTexamplecom', password: 'test12345', password_confirmation: 'test12345'})
		assert !user.save, 'Should NOT save!'
		assert_equal(true, user.errors.messages[:email].include?('is invalid'))

		user = User.new({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: 'TeST@example.com', password: 'test12345', password_confirmation: 'test12345'})
		user_dup = User.new({ first_name: 'Jan', last_name: 'Kowalski', login: 'jkow', email: 'TeST@example.com', password: 'test1234567', password_confirmation: 'test1234567'})
		assert user.save, 'Should save!'
		assert !user_dup.save, 'Should NOT SAVE'
		assert_equal(true, user_dup.errors.messages[:email].include?('has already been taken'))



		user = User.new({first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda',  email: 'mf@test.com', password: 'test12345', password_confirmation: 'test12345'})
		assert user.save, 'Should save'
	end

	test 'roles' do
		user = User.create!({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: 'test31@example.com', password: 'test12345', password_confirmation: 'test12345'})
		admin = User.create!({ first_name: 'Mateusz', last_name: 'Fundakowski', login: 'mfunda', email: 'test132@example.com', password: 'test12345', password_confirmation: 'test12345'})
		user.save
		admin.role = 'Admin'
		admin.save
		user = User.find(user.id)
		admin = User.find(admin.id)
		assert_equal(false, user.is_a?(Admin))
		assert_equal(true, admin.is_a?(Admin))
	end
end
