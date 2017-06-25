class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
    end

    create_table :roles_users, id: false do |t|
      t.belongs_to :user, index: true, unique: true
      t.belongs_to :role, index: true, unique: true
    end
  end
end
