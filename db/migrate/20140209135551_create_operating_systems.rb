class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :name
      t.string :codename
      t.string :ancestry
      t.date :supported_until
      t.timestamps
    end
  end
end
