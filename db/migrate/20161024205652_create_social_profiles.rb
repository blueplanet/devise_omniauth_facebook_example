class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.string :provider, nill: false
      t.string :uid, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
