require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ContactController, type: :controller do
  context "when user is not logged" do 
    describe "#index" do 
      subject{get :index}
      it_behaves_like "not_signed_user_action"
    end

    describe "#create" do 
      subject{post :create}
      it_behaves_like "not_signed_user_action"
    end

    describe "#destroy" do 
      subject{delete :destroy, params: { id: 1 } }
      it_behaves_like "not_signed_user_action"
    end

    describe "#new" do 
      subject{get :new }
      it_behaves_like "not_signed_user_action"
    end

    describe "#import" do 
      subject{post :import, params: { id: 1 }}
      it_behaves_like "not_signed_user_action"
    end
  end

  context "when user is logged" do 
    let(:user) {create :user}
    before{ sign_in user }

    describe "#index" do 
      subject{get :index}
      it "should have a success response" do 
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    describe "#create" do 
      context "when valid file provided" do 
        let(:file_path) {"spec/csv_files/valid_contacts.csv"}
        let(:params) {
          {contact_file: { file: Rack::Test::UploadedFile.new(file_path, 'text/csv') } }
        }
        subject {post :create, params: params}
        it "should redirect to contact_files_path" do 
          subject 
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to eq("File uploaded successfully")
         
        end

        it "should create a contact_file" do 
          expect{subject}.to change{ContactFile.count}.by(1)
        end
      end

      context "when no file provided" do 
        subject {post :create, params: {}}
        it "should redirect to contact_files_path" do 
          subject
          expect(response).to have_http_status(:found)
          expect(flash[:alert]).to eq("No file provided")
          
        end
      end
    end


    describe "#new" do 
      context "when valid file provided" do
        csv_file = create_csv_file("spec/csv_files/valid_contacts.csv")
        let(:contact_file) {create :contact_file, csv_file: csv_file, user: user}
        
        subject{get :new }

        it "should have a succes response" do 
          subject
          expect(response).to have_http_status(:ok)
        end
      end
    end

  end
end