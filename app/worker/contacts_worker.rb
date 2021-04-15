class ContactsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false
  def perform(csv_file, user)
    #contact_file = Contact.find(contact_file_id)
    Contact.import(csv_file, user)
  end
end 