class CreateRedirects < ActiveRecord::Migration
  
  def self.up
    create_table :redirects do |t|
      t.string :old_url
      t.string :new_url
      t.timestamps
    end
  end

  def self.down
    drop_table :redirects
  end

end
