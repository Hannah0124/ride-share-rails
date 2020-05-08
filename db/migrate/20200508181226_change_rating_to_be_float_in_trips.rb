class ChangeRatingToBeFloatInTrips < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :rating, :float
  end
end
