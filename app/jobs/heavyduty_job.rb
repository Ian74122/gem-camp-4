class HeavydutyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep 5
  end
end
