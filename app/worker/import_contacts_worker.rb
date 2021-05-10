class ImportContactsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false
  #user = current_user
  
  def perform(generated_file, user_id)
    user = User.find(user_id)
    #generated_file = '/home/chris/reto_koombea/importador_de_contactos2/public/generated_data.csv'
    #generated_file = "#{Rails.root}/public/generated_data.csv"

    begin  
      CSV.foreach(generated_file, headers: true) do |row|
        puts '----***----'
        puts "processing contact #{row}"
        puts '----***----'

        if user.contacts.create! row.to_hash
          puts '----***----'
          puts "processed contact #{row}"
          puts '----***----'
          #else 
          #puts '----***----'
          #puts "contact #{row}, #{e}, failed while uploading"
          #puts '----***----'
          
        end 
      rescue ActiveRecord::RecordInvalid => e
        puts '----***----'
        puts "Record invalid:#{e}"
        puts '----***----'
        puts "contact #{row}, failed while uploading"
        puts "---***---"
        puts '-xxxxxxxxx-'
        puts '----***----'
        puts "uploading: #{row}, to failed contacts database"
        puts '----***----'
        #begin
        row["error_data"] = e.to_s
        #  rescue ActiveRecord::NoMethodError => e

        puts row
        puts '----****---'
        #begin
        user.failcontacts.create! row.to_hash
        #rescue ActiveRecord::NoMethodError => e
      
          #puts e
          puts  '---oooooooooooo----'
          puts row.to_hash
          puts row['error_data']
          puts  '---oooooooooooo----'

          puts '----***----'
          puts "contact saved in failed: #{row}"
          puts '----***----'
        #end
      rescue ActiveModel::UnknownAttributeError => e
        puts e       
      end
    end
  end
end 