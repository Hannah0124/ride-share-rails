class SetDefaultValueAsAvailableToDrivers < ActiveRecord::Migration[6.0]
  def change
    change_column :drivers, :available, :boolean, :default => true
  end
end


# reference: https://stackoverflow.com/questions/22216355/how-to-add-default-value-to-a-column-being-added-through-rails-g-migration-com/22216405