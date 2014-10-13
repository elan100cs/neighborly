require 'spec_helper'

describe DiscoverController do
  before do
    sign_in create(:user, :beta)
    create(:project, recommended: true)
  end

  describe 'GET index' do
    before { get :index }

    it 'assigns a presenter' do
      expect(assigns(:presenter)).not_to be_nil
    end

    it 'presenter is a DiscoverPresenter instance' do
      expect(assigns(:presenter)).to be_instance_of(DiscoverPresenter)
    end
  end
end
