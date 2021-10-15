class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.references :team, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
