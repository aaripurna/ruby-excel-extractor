require 'nokogiri'
require 'csv'

for i in 1..17 do
    
    file = File.read(File.expand_path("carts/chart#{i}.xml", __dir__))
    xml = Nokogiri::XML(file)

    File.write(File.expand_path("outputs/chart#{i}.csv", __dir__), "")
    puts "outputs/chart#{i}.csv"
    CSV.open(File.expand_path("outputs/chart#{i}.csv", __dir__), "wb") do |csv|
        headers = xml.at("//c:plotArea //c:cat").xpath(". //c:v").map{ |i| i.text.to_s.to_i }
        headers.insert(0, "Category")
        csv << headers

        xml.xpath("//c:ser").each do |item|
            title = item.xpath(". //c:tx //c:strRef //c:v").text.to_s
            values = item.xpath(". //c:val //c:numRef //c:v").map { |i| i.text.to_s.to_f }
            row = values.insert(0, title)
            puts row
            puts "---------------------------------------------"

            csv << row
        end
    end
end