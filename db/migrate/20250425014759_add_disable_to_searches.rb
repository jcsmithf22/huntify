class AddDisableToSearches < ActiveRecord::Migration[8.0]
  def change
    add_column :searches, :disable, :boolean, default: false
    rename_column :searches, :include_description, :title_only
    change_column_default :searches, :title_only, false
  end
end
