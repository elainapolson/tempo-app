class CreateBillboards < ActiveRecord::Migration
  def change
    create_table :billboards do |t|

      t.timestamps null: false
    end
  end
end
