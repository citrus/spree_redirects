class AddStatusCodeToRedirects < ActiveRecord::Migration
  def change
    add_column :spree_redirects, :status_code, :integer
  end
end
