class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider,   null: false
      t.string :uid,        null: false
      t.string :username,   null: false
      t.string :name,       null: false
      t.string :avatar_url, null: false

      t.timestamps
    end

    add_index :users, [:provider, :uid], unique: true

    reversible do |direction|
      direction.up do
        execute <<-SQL.squish
          ALTER TABLE users ADD CONSTRAINT valid_provider CHECK (provider <> '');
          ALTER TABLE users ADD CONSTRAINT valid_uid CHECK (uid <> '');
          ALTER TABLE users ADD CONSTRAINT valid_username CHECK (username <> '');
          ALTER TABLE users ADD CONSTRAINT valid_name CHECK (name <> '');
          ALTER TABLE users ADD CONSTRAINT valid_avatar_url CHECK (avatar_url <> '');
        SQL
      end
    end
  end
end
