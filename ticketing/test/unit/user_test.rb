require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :users

  test "Setting User student number stores the hash" do
    u = users(:tester)
    u.student_number = '00000000'
    assert_equal u.student_number_hash, '7e071fd9b023ed8f18458a73613a0834f6220bd5cc50357ba3493c6040a9ea8c'
  end

  test "Valid email address accepted" do
    u = users(:tester)
    u.email = 'testing@uwaterloo.ca'
    assert u.save, "User rejects a valid email address: " + u.errors.full_messages.inspect
  end

  test "Invalid email address rejected" do
    u = users(:tester)
    u.email = 'notavalidemail@something'
    assert !u.save, "User accepts an invalid email address: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:email)
  end

  test "User requires first name" do
    u = users(:tester)
    u.first_name = nil
    assert !u.save, "User accepts an entry without first name: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:first_name)
  end

  test "User requires last name" do
    u = users(:tester)
    u.last_name = nil
    assert !u.save, "User accepts an entry without last name: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:last_name)
  end

  test "User requires email" do
    u = users(:tester)
    u.email = nil
    assert !u.save, "User accepts an entry without email: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:email)
  end

  test "Setting student_number requires confirmation" do
    u = users(:tester)
    u.student_number = '00000000'
    assert !u.save, "User.student_number can be set without confirmation: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:student_number_confirmation)

    u = users(:tester)
    u.student_number = '00000000'
    u.student_number_confirmation = '11111111'
    assert !u.save, "User.student_number can be set with invalid confirmation: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:student_number)

    u = users(:tester)
    u.student_number = '12345678'
    u.student_number_confirmation = '12345678'
    assert u.save, "User.student_number cannot be set with valid confirmation: " + u.errors.full_messages.inspect
  end

  test "Userid is required" do
    u = users(:tester)
    u.userid = nil
    assert !u.save, "User accepts an entry without userid: " + u.errors.full_messages.inspect
    assert u.errors.invalid?(:userid)
  end
end
