namespace :data do
  desc 'Populate the DB with data'
  task populate: :environment do
    100.times do |n|
      story = Story.new
      story.title = "Story #{n}"
      story.creator = User.first
      fragment = story.fragments.new
      fragment.content = "<p>Lorem Ipsum</p>"
      fragment.author = User.first
      
      story.save!
    end
  end
end
