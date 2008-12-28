class CreateStatusReports < ActiveRecord::Migration
  def self.up
    create_table :status_reports do |t|
      t.references :project
      t.references :user
      t.text :yesterday
      t.text :today
      t.date :status_date

      t.timestamps
    end
  end

  def self.down
    drop_table :status_reports
  end
end
