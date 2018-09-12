require 'soda/client'
require 'date'

client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => "rnCvC24au6ZMSOdg7EEaEV9Uv"})

results = client.get("/resource/bbb8-hzi6", :$limit => 5000).sort_by{|k| k.applicant}


def find_results(results)
  d = DateTime.now
  current_time = d.strftime("%H:%M")
  day = Date.today.strftime("%A")
  new_results = []

  results.each do |i|
    if i.start24 <= current_time && i.end24 >= current_time
      if i.dayofweekstr == day
        new_results.push(i)
      end
    end
    results.delete(i)
  end
  new_results.first(10).each do |j|
    puts j.applicant
    puts j.location
    puts j.start24
    puts j.end24
    puts j.dayofweekstr
    puts "\n"
  end
  if !results.empty?
    puts "Would you like to see more results?"
    answer = gets.chomp.downcase
    if answer == 'yes' || answer == 'y'
      find_results(results)
    end
  else
    puts "No other trucks are open at this time."
  end
end


  puts "The following food trucks are currently open:"
  puts "\n"
  find_results(results)
