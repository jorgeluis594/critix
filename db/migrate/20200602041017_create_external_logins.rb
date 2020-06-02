class CreateExternalLogins < ActiveRecord::Migration[6.0]
  def change
    create_table :external_logins do |t|
      t.string :provider
      t.string :uid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
