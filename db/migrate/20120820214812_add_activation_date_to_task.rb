class AddActivationDateToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :nextActivationDate, :datetime
    rename_column :tasks, :lastReminderDelay, :lastActivationOffset
    Task.reset_column_information
    Task.all.each do |t|
      t.update_column :nextActivationDate, t.created_at.advance(days: t.lastActivationOffset).beginning_of_day() 
    end
  end

end
