begin
  
  FactoryGirl.define do
    
    factory :user do
      email { random_email }
      password "spree123"
      password_confirmation "spree123"
      roles { [Role.find_or_create_by_name("user")] }
    end
  
    factory :admin_user, :parent => :user do
      roles { [Role.find_or_create_by_name("admin")] }
    end
  
  end
  
rescue FactoryGirl::DuplicateDefinitionError
  
  puts "factories are already defined..."
  
end