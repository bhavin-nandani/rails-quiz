class CreateJoinTableCompanyPeople < ActiveRecord::Migration[7.0]
  def change
    create_join_table :companies, :people do |t|
      t.index [:company_id, :person_id]
      t.index [:person_id, :company_id]
    end
  end
end
