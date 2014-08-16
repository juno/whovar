class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, null: false, index: true
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end

    reversible do |direction|
      direction.up do
        execute <<-SQL.squish
          ALTER TABLE items ADD FOREIGN KEY (user_id) REFERENCES users (id);
          ALTER TABLE items ADD CONSTRAINT valid_title CHECK (title <> '');
          ALTER TABLE items ADD CONSTRAINT valid_url CHECK (url <> '');
        SQL
      end
    end
  end
end
