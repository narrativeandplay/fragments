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

  task :clone_story, [:story_id, :count] => :environment do |t, args|
    args[:count].to_i.times do
      story_to_clone = Story.find args[:story_id]

      fragments_to_clone = story_to_clone.fragments.first

      new_story = story_to_clone.dup

      new_story.save!

      def clone_fragment(fragment_to_clone, story, parent)
        cloned_fragment = story.fragments.build(parent: parent,
                                                content: fragment_to_clone.content,
                                                created_at: fragment_to_clone.created_at,
                                                author_id: fragment_to_clone.author_id)

        cloned_fragment.save!

        fragment_to_clone.children.each { |f| clone_fragment f, story, cloned_fragment }
      end

      clone_fragment fragments_to_clone, new_story, nil
    end
  end
end
