module BuildingsHelper
   def user_photos(user_id, tag, photo_count = 8)
    flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
    #search by tags sort by date taken
    flickr.photos.search(:user_id => @flickr_id, :tags => tag.gsub(/_|\s/,'').downcase, :per_page => photo_count, :page => 1)
  end
  
  def render_flickr_sidebar_widget(user_id, tag, photo_count = 8)
    begin
      photos = user_photos(user_id, tag, photo_count).sort {|p1, p2| p1.title <=> p2.title}
      render :partial => '/buildings/sidebar_widget', :locals => { :photos => photos }
    rescue Exception
      render :partial => '/buildings/unavailable'
    end
  end

   #Truncates a given comment to the passed in size, without breaking words.
  #Additionally, converts newlines to html break tags, and will truncate
  #on a newline if the newline falls within the truncated length.
  #does not h the comment
  def truncate_comment(comment, num_characters = 150)
    comment_copy = ""
    comment_size = 0

    comment.each(" ") do |w|
      if comment_size + w.size > num_characters
        break
      else
        comment_size += w.size
        comment_copy += " #{w}" 
      end
    end

      first_newline = comment_copy[0..(num_characters - 1)].index("\n")

      if first_newline and comment.size != num_characters
        comment_copy = comment_copy[0..(first_newline - 1)] + "..."
      elsif comment.size > comment_size
        comment_copy += "..."
      end

    return comment_copy.gsub("\n", '<br />')
  end
end
