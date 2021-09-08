require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @contact =
      @user.contacts.create(
        name: "Eric",
        email: 'e@e.com',
        phone: '3456-03556',
        notes: 'Do not contact on weekends'
      )
  end

   test 'should be valid' do
    assert @contact.valid?
  end

   test 'name should be present' do
    @contact.name = ' '
    assert_not @contact.valid?
  end

  	test 'user_id should be present' do
		@contact.user_id = ' '
		assert_not @contact.valid?
	end
end
