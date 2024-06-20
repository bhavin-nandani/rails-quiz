json.people @people do |person|
    json.extract! person, :id , :name, :email, :phone_number
end

json.page @people.current_page
json.per_page @people.limit_value
json.total_pages @people.total_pages
json.total_count @people.total_count
