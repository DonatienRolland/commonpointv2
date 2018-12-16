require 'csv'


p "création des catégories"
sport = Category.create!(title: "Sport")
culture = Category.create!(title: "Culture")


p "création des activités"
csv_file_activity   = File.join(__dir__, 'activities.csv')

CSV.foreach(csv_file_activity) do |row|
  if row[0]
    act = Activity.create!(title: row[0].downcase.capitalize, category: sport)
  end
  if row[1]
    act = Activity.create!(title: row[1].downcase.capitalize, category: culture)
  end
  if row[2]
    act = Activity.create!(title: row[2].downcase.capitalize, category: culture)
  end
  p "add #{act.title}"
end
