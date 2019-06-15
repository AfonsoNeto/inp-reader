class InpWorker
  include Sidekiq::Worker

  def perform
    puts 'Do the hard job...'
  end
end
