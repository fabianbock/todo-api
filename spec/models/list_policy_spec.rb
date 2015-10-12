require 'rails_helper'

describe ListPolicy do
  describe ListPolicy::Scope do
    describe '#resolve' do
      let(:results) { ListPolicy::Scope.new(List.all, user).resolve }
      let(:user) { User.create!(email: 'a@a.com', password: '12345678') }
      let(:other_user) { User.create!(email: 'b@b.com', password: '12345678') }
      let!(:user_private_list) { user.lists.create!(title: 'asdf', permissions: 'private') }
      let!(:user_viewable_list) { user.lists.create!(title: 'asdf', permissions: 'viewable') }
      let!(:other_user_private_list) { other_user.lists.create!(title: 'asdf', permissions: 'private') }
      let!(:other_user_viewable_list) { other_user.lists.create!(title: 'asdf', permissions: 'viewable') }

      it 'returns Lists belonging to the current user' do
        expect(results).to include(user_viewable_list, user_private_list)
      end

      it "it returns 'open/viewable' lists belonging to other users" do
        expect(results).to include(other_user_viewable_list)
      end

      it "it does not return 'private' lists belonging to other users" do
        expect(results).to_not include(other_user_private_list)
      end
    end
  end
end