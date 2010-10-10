class RoleassocIdRefactor < ActiveRecord::Migration
  def self.up
    # refactor "roleassoc belongs to role"
    #   and "roleassoc belongs to user"
    add_column :roleassocs, :role_id, :integer
    add_column :roleassocs, :user_id, :integer
    Roleassoc.all.each do |ra|
      role = Role.find_by_rabbrev(ra.roleid)
      ra.role_id = role.id unless role.nil?
      user = User.find_by_name(ra.userid)
      ra.user_id = user.id unless user.nil?
      ra.save!
    end
    remove_column :roleassocs, :roleid
    remove_column :roleassocs, :userid
  end

  def self.down
    add_column :roleassocs, :roleid, :string
    add_column :roleassocs, :userid, :string
    Roleassoc.all.each do |ra|
      ra.roleid = ra.role.rabbrev
      ra.userid = ra.user.name
    end
    remove_column :roleassocs, :role_id
    remove_column :roleassocs, :user_id
  end
end
