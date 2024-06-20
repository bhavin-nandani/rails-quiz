json.companies @companies do |company|
    json.extract! company, :id, :name
  end
  
  json.page @companies.current_page
  json.per_page @companies.limit_value
  json.total_pages @companies.total_pages
  json.total_count @companies.total_count
  