namespace :tzinfo do
  desc "look into implementation of in_time_zone()"
  task patch: :environment do
    Timecop.freeze(Time.new(2015, 8, 15, 0, 0, 0, "+00:00"))
    load File.join(File.dirname(File.expand_path(__FILE__)), 'tzinfo_patch.rb')
    puts Time.now.in_time_zone('Asia/Pyongyang')
  end
end
