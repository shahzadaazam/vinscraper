require 'HTTParty'
require 'Pry'
require 'Nokogiri'
require 'csv'
require 'JSON'
require 'mechanize'

vin_numbers = []
input_file_name = []

results = []
final_results = []
i = 0;

#Ask the user for the input file name

puts "\n"
puts "***************** VINSCRAPER 1.0 *****************\n"
puts "--------------------------------------------------\n"
puts "      Motorcycle Injury Prevention Institute      \n"
puts "     Center for Urban Transportation Research     \n"
puts "--------------------------------------------------\n"

puts "\n"

puts "--------------------------------------------------\n"
puts "Developed for @Dr.Chanyoung Lee by @Shahzada Azam\n"
puts "--------------------------------------------------\n"

puts "\n"

puts "Please place your input file in CSV format in the current working directory."
puts "The VIN numbers must be listed int he first column starting from the first row. Any header rows/labels must be deleted."

puts "\n"

print "- Please enter input file name (without extension): \n"

input_file_name = gets().chomp

input_file_name = input_file_name + ".csv"

puts "Your input file is " + input_file_name



if File.file?(input_file_name) && File.exist?(input_file_name)
  print "- Reading file......\n"

  csv_file = File.read(input_file_name)
  csv = CSV.parse(csv_file, :headers => false)
  csv.each do |row|
    vin_numbers.push(row[0])
  end

  #Test printing out un-sanitized VINs
  # vin_numbers.each do |row|
  #   puts row
  # end

  #Sanitizing VIN numbers by removing / - . and anything other than numbers and alphabets
  vin_numbers.each do |row|
    # puts "printing row"
    row.gsub!(/[^0-9A-Za-z]/, '')
    # puts row
  end



  # p vin_numbers //for printing out VINs

  puts "There are " + vin_numbers.count.to_s + " VIN entries in the file."

  print "- Starting scraping......\n"

  CSV.open('results.csv', 'w') do |csv|

    while i <= vin_numbers.count
      vin_number_output = vin_numbers[i]
      agent = Mechanize.new
      page = agent.get('http://www.iihs-hldi.org/MotovinDirect.asp?ccr=EHS7N5F2F2L5&scr')

      form = page.form('frmVIN')
      form.txtVIN = vin_numbers[i]
      i = i + 1;
      page = agent.submit(form)

      page.search("td").each do |item|
        results.push(item.text.strip)
      end

      # vin = results[6]
      # hldi_class_name = results[20]

      count = 0
      index = 0

      for j in results

        if j == "Displacement"
          index = count
        end
        count = count + 1
      end

      hldi_class_name = results[index-1]

      # puts "****** HlDI Class Name *******"
      puts "HLDI Class name: " + hldi_class_name

      final_results.push(vin_number_output, hldi_class_name)

      csv << final_results

      # puts results

      results.clear
      final_results.clear

    end

  end

  puts "Scraping complete!"



else
  print " File " + input_file_name + " doesn't exist in the current directory\n"
  print " Please place file in current directory and run this script again\n"
  return
end




