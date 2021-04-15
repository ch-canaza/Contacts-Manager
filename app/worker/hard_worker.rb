class HardWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  
  def perform(*args)
  end
end