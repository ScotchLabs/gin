class AddBoxofficeToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :rboxoffice, :string
    r=Role.find_by_rabbrev("tixer")
    r.rboxoffice="r" if !r.nil?
    puts r.save if !r.nil?
    r=Role.find_by_rabbrev("admin")
    r.rboxoffice="r" if !r.nil?
    puts r.save if !r.nil?
  end

  def self.down
    remove_column :roles, :rboxoffice
  end
end
