namespace :spree_redirects do
  desc 'Import redirects from a CSV file'
  task :import_csv, [:filename] => :environment do |task, args|
    require 'csv'
    filename = args[:filename]
    puts "Importing #{filename}"
    rows = CSV.read(filename)
    headers = rows.shift
    errors = []
    
    rows.each_with_index do |row, i|
      
      if row[0].blank? || row[1].blank?
        errors << "Row #{i+2}: Error: Blank URL"
        next
      end 
      
      begin
        old_url = URI(row[0].strip).path
        new_url = URI(row[1].strip).path
        status_code = row[2] ? row[2] : nil
        redirect = Spree::Redirect.find_by_old_url(old_url)
        if redirect
          puts "Row #{i+2}: #{old_url} -> #{new_url} - updating existing redirect"
          redirect.update_attributes new_url: new_url, status_code: status_code
        else
          puts "Row #{i+2}: #{old_url} -> #{new_url} - creating new redirect"
          redirect = Spree::Redirect.new old_url: old_url, new_url: new_url, status_code: status_code
          redirect.save
        end
      rescue URI::InvalidURIError => e
        errors << "Row #{i+2}: Error #{e.message}"
      end
    end
    
    puts
    puts "#{errors.size} errors"
    if errors.size > 0
      errors.each do |error|
        puts error
      end
    end
    
  end
end