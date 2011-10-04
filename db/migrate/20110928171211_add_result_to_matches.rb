class AddResultToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :result, :string
  end
end
