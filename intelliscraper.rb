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
    row.to_s.gsub!(/[^0-9A-Za-z]/, '')
    # puts row
  end



  # p vin_numbers //for printing out VINs

  puts "There are " + vin_numbers.count.to_s + " VIN entries in the file."

  print "- Starting scraping......\n"

  CSV.open('results.csv', 'w') do |csv|

    while i <= vin_numbers.count
      vin_number_input = vin_numbers[i]
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


      #Code for VIN Output

      count = 0
      index = 0

      for j in results

        if j == "Output VIN"
          index = count
        end
        count = count + 1
      end

      vin_number_output = results[index+1]

      # puts "****** Output VIN *******"
      # puts "Output VIN: " + vin_number_output


      #Code for Check Digit

      count = 0
      index = 0

      for j in results

        if j == "Check Digit"
          index = count
        end
        count = count + 1
      end

      check_digit = results[index+1]

      # puts "****** Check Digit *******"
      # puts "Check Digit: " + check_digit

      #Code for Model Year

      count = 0
      index = 0

      for j in results

        if j == "Model"
          index = count
        end
        count = count + 1
      end

      model_year = results[index+1]

      # puts "****** Model Year *******"
      # puts "Model Year: " + model_year


      #Code for Make

      count = 0
      index = 0

      for j in results

        if j == "Model"
          index = count
        end
        count = count + 1
      end

      make = results[index+2]

      # puts "****** Make *******"
      # puts "Make: " + make


      #Code for Series

      count = 0
      index = 0

      for j in results

        if j == "Model"
          index = count
        end
        count = count + 1
      end

      series = results[index+3]

      # puts "****** Series *******"
      # puts "Series: " + series


      #Code for Model

      count = 0
      index = 0

      for j in results

        if j == "Model"
          index = count
        end
        count = count + 1
      end

      model = results[index+4]

      # puts "****** Model *******"
      # puts "Model: " + model


      #Code for HLDI class name
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
      # puts "HLDI Class name: " + hldi_class_name

      #Code for Displacement

      count = 0
      index = 0

      for j in results

        if j == "Displacement"
          index = count
        end
        count = count + 1
      end

      displacement = results[index+1]

      # puts "****** Displacement *******"
      # puts "Displacement: " + displacement


      #Code for Price

      count = 0
      index = 0

      for j in results

        if j == "Price"
          index = count
        end
        count = count + 1
      end

      price = results[index+1]

      # puts "****** Price *******"
      # puts "Price: " + price


      #Code for Weight

      count = 0
      index = 0

      for j in results

        if j == "Weight"
          index = count
        end
        count = count + 1
      end

      weight = results[index+1]

      # puts "****** Weight *******"
      # puts "Weight: " + weight


      #Code for Wheelbase

      count = 0
      index = 0

      for j in results

        if j == "Wheelbase"
          index = count
        end
        count = count + 1
      end

      wheelbase = results[index+1]

      # puts "****** Wheelbase *******"
      # puts "Wheelbase: " + wheelbase


      #Code for ABS

      count = 0
      index = 0

      for j in results

        if j == "ABS"
          index = count
        end
        count = count + 1
      end

      abs = results[index+1]

      # puts "****** ABS *******"
      # puts "ABS: " + abs


      #Code for Transmission

      count = 0
      index = 0

      for j in results

        if j == "Transmission"
          index = count
        end
        count = count + 1
      end

      transmission = results[index+1]

      # puts "****** Transmission *******"
      # puts "Transmission: " + transmission

      #Code for Drive

      count = 0
      index = 0

      for j in results

        if j == "Transmission"
          index = count
        end
        count = count + 1
      end

      drive = results[index+3]

      # puts "****** Drive *******"
      # puts "Drive: " + drive


      #Code for Engine Type

      count = 0
      index = 0

      for j in results

        if j == "HorsePower"
          index = count
        end
        count = count + 1
      end

      engine_type = results[index+1]

      # puts "****** Engine Type *******"
      # puts "Engine Type: " + engine_type


      #Code for Engine Drive

      count = 0
      index = 0

      for j in results

        if j == "HorsePower"
          index = count
        end
        count = count + 1
      end

      engine_drive = results[index+2]

      # puts "****** Engine Drive *******"
      # puts "Engine Drive: " + engine_drive


      #Code for Torque

      count = 0
      index = 0

      for j in results

        if j == "Torque"
          index = count
        end
        count = count + 1
      end

      torque = results[index+4]

      # puts "****** Torque *******"
      # puts "Torque: " + torque


      #Code for HorsePower

      count = 0
      index = 0

      for j in results

        if j == "HorsePower"
          index = count
        end
        count = count + 1
      end

      horsepower = results[index+4]

      # puts "****** HorsePower *******"
      # puts "HorsePower: " + horsepower


      final_results.push(vin_number_input,vin_number_output, check_digit, model_year, make, series, model, hldi_class_name, displacement, price, weight, wheelbase, abs, transmission, drive, engine_type, engine_drive, torque, horsepower)


      # puts results

      #Sanitizing final_results

      for j in final_results
        if j == "ENTER MOTORCYCLE VIN"
          j.to_s.gsub!(/(ENTER MOTORCYCLE VIN)/, '')
        end
      end

      for k in final_results
        k.to_s.gsub!(/[^0-9A-Za-z]/, '')
      end

      # final_results.gsub!(/[^ENTER MOTORCYCLE VIN]/, '')


      puts ""
      puts final_results
      puts ""

      csv << final_results

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




