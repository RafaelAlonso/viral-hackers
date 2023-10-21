class FakeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "I'm starting the fake job"
    sleep 3
    puts "Ok, I'm done now"
  end
end