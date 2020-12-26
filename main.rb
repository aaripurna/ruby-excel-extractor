require 'nokogiri'
require 'csv'

Dir.glob(File.expand_path("carts/*.xml", __dir__)).each do |file|
    
    file_string = File.read(file)
    xml = Nokogiri::XML(file_string)
    
    file_name = file.split('/').last.gsub('.xml', '.csv')

    File.write(File.expand_path("outputs/#{file_name}", __dir__), "")
    puts "outputs/#{file_name}"
    CSV.open(File.expand_path("outputs/#{file_name}", __dir__), "wb") do |csv|
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