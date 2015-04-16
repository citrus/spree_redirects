namespace :spree_redirects do
  desc 'Import redirects from an NGINX .conf file'
  task :import_nginx_conf, [:filename] => :environment do |task, args|
    filename = args[:filename]
    puts "Importing #{filename}"
    errors = []    #     errors << "Row #{i+2}: Error: Blank URL"


    f = File.new(filename)
    f.each do |line|
      next unless line.start_with? 'rewrite'

      old_url, rest = line.sub('rewrite ^', '').sub(/;\n/, '').split('$')
      new_url, permanence = rest.split(' ')
      status_code = (permanence == 'permanent' ? 301 : 302)

      begin
        redirect = Spree::Redirect.find_by_old_url(old_url)
        if redirect
          puts "Line #{f.lineno}: #{status_code} #{old_url} -> #{new_url} - updating existing redirect"
          redirect.update_attributes new_url: new_url, status_code: status_code
        else
          puts "Line #{f.lineno}: #{status_code} #{old_url} -> #{new_url} - creating new redirect"
          redirect = Spree::Redirect.new old_url: old_url, new_url: new_url, status_code: status_code
          redirect.save
        end
      rescue URI::InvalidURIError => e
        errors << "Line #{f.lineno}:  Error #{e.message}"
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
