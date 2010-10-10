class CreateScaffolding < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :title
      t.string :anchor
      t.boolean :publish
      t.integer :order
      t.text :article
      t.string :contentpane
      t.string :contenttype

      t.timestamps
    end
    
    create_table :shows do |t|
      t.string :name
      t.string :abbrev
      t.string :loc
      t.string :imageurl
      t.string :author
      t.string :performancetimes
      t.string :ticketstatus
      t.string :director
      t.boolean :timesvisible
      t.string :shortdisplayname
      t.string :housemanname
      t.string :housemanemail
      t.text :ticketnotes
      t.string :seatingmap
      t.string :slot

      t.timestamps
    end
    
    create_table :updates do |t|
      t.string :name
      t.string :anchor
      t.datetime :expiredate
      t.text :article

      t.timestamps
    end
    
    create_table :users do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.string :email

      t.timestamps
    end
    
    create_table :roleassocs do |t|
      t.integer :role_id
      t.integer :user_id

      t.timestamps
    end
    
    create_table :roles do |t|
      t.string :rname
      t.string :rabbrev
      t.string :rcontents
      t.string :rrezlineitems
      t.string :rroleassocs
      t.string :rroles
      t.string :rshows
      t.string :rticketalerts
      t.string :rticketrezs
      t.string :rticketsections
      t.string :rupdates
      t.string :rusers
      t.string :rboxoffice
    end
    
    create_table :ticketalerts do |t|
      t.integer :show_id
      t.string :email

      t.timestamps
    end
    
    create_table :ticketrezs do |t|
      t.integer :show_id
      t.string :name
      t.string :email
      t.string :phone
      t.boolean :hasid
      t.string :salt
      t.string :hashid
      t.string :phone

      t.timestamps
    end
    
    create_table :ticketsections do |t|
      t.integer :show_id
      t.string :name
      t.integer :size
      t.integer :pricewithid
      t.integer :pricewoutid

      t.timestamps
    end
    
    create_table :rezlineitems do |t|
      t.integer :ticketrez_id
      t.string :performance
      t.integer :ticketsection_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
    drop_table :panes
    drop_table :shows
    drop_table :updates
    drop_table :users
    drop_table :roleassocs
    drop_table :roles
    drop_table :ticketalerts
    drop_table :ticketrezs
    drop_table :ticketsections
    drop_table :rezlineitems
  end
end