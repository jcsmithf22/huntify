class ChangeTypeToListingType < ActiveRecord::Migration[8.0]
  def change
    rename_column :searches, :type, :listing_type
  end
end
