module PostsHelper

  GOOGLE_API_KEY = "AIzaSyD8g99jeyrwwrGshZYnWEARNnAmZ_JPcUk"

  def find_videos(keyword, youtube_id, after: 1.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    service.list_videos(:snippet, id: youtube_id)
  end


end
