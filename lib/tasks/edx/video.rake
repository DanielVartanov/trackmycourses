require 'open-uri'

namespace :edx do
  task video: [:environment, :init_grabber] do
    grabber = init_grabber
    platform = Platform[:edx]

    platform.courses.each do |course|
      puts "Course: #{course.title} #{course.url}"
      course.chapters.each do |chapter|
        chapter.lectures.where(duration: -1).each do |lecture|
          puts "  Lecture: #{lecture.title}"
          grabber.get lecture.url

          video_ids = []
          video_ids = grabber.page.search('body').text.scan(/1\.0:([a-zA-Z0-9\-_]{11})/).flatten

          if video_ids.empty?
            node = grabber.page.search('div.video')
            if node.present?
              video_ids.push node.attr("data-streams").value.split(':').last
            end
          end


          lecture_duration = 0
          video_ids.each do |video_id|
            doc = Nokogiri::XML open("https://gdata.youtube.com/feeds/api/videos/#{video_id}?v=2")
            doc.remove_namespaces!
            lecture_duration += doc.xpath("//duration").attr('seconds').value.to_i
            sleep 1
          end
          lecture.duration = lecture_duration
          puts "    Lecture duration: #{lecture.duration}"
          lecture.save
        end
      end
    end

    puts "Lecture durations are updated"
  end
end
