require 'spec_helper'
describe MessagesController do

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new message in the database' do
        expect{
          post :create, message: FactoryGirl.attributes_for(:message)
        }.to change(Message, :count).by(1)
      end
      it 'redirects to messages#show' do
        post :create, message: FactoryGirl.attributes_for(:message)
        expect(response).to redirect_to message_path(assigns[:message])
      end
    end
    context 'with invalid attributes' do
      it 'does not save the new message in the database' do
        expect{
          post :create, message: FactoryGirl.attributes_for(:message, title: '')
        }.to_not change(Message, :count)
      end
      it 're-renders the :new tempalte' do
        post :create, message: FactoryGirl.attributes_for(:message, title:'')
        expect(response).to render_template :new
      end
    end
  end
end