require "test_helper"

class ContactsCreateTest < ActionDispatch::IntegrationTest
 
def setup
@user = users(:one)
end

	test 'invalid create contact information' do
		log_in_as(@user)
get address_book_path(@user)
assert_template 'contacts/index'
assert_select 'a', '+ Add contact'
		# assert_equal before_count, after_count is same as:
		assert_no_difference 'Contact.count' do
			post user_contacts_path(@user), params:
			      { contact: { 
name: "",
        email: 'granny@g.com',
        phone: '123456789',
        notes: "My mom's mom" } }
		end
    follow_redirect!
		assert_template 'contacts/index'
		assert_not flash.empty?
    assert_select 'div.alert-danger', 'Error creating contact. Please try again.'
	end

	test 'valid create contact information' do
	log_in_as(@user)
get address_book_path(@user)
assert_template 'contacts/index'
assert_select 'a', '+ Add contact'
		# assert_equal before_count, after_count is same as:
		assert_difference 'Contact.count', 1 do
			post user_contacts_path(@user), params:
			      { contact: { 
name: "Granny",
        email: 'granny@g.com',
        phone: '123456789',
        notes: "My mom's mom" } }
		end
    follow_redirect!
		assert_template 'contacts/index'
		assert flash.empty?
	end


end
