puts "creating 10 records for shorten_url table"

10.times do |i|
  ShortenUrl.create_record("http://google.com/#{SecureRandom.hex(10)}")
end

puts "creating some records for url_statistic table"

ShortenUrl.all.each do |url|
  5.times do |i|
    UrlStatistic.create!(
      ip_address: "127.0.0.#{rand(1..5)}",
      shorten_url_id: url.id,
      created_at: rand(5.days).seconds.ago
    )
  end

  10.times do |i|
    UrlStatistic.create!(
      ip_address: "127.0.0.#{rand(1..3)}",
      shorten_url_id: url.id,
      created_at: rand(10.hours).seconds.ago
    )
  end
end

puts "done"


