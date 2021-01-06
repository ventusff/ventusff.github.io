require 'json'
# Based on code at https://blog.sverrirs.com/2016/04/custom-jekyll-tags.html

module Jekyll

  class ImageInLightbox < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    # Lookup allows access to the page/post variables through the tag context
    def lookup(context, name)
      lookup = context
      name.split(".").each { |value| lookup = lookup[value] }
      lookup
    end

    def render(context)
    
      # Set defaults first
      alt = ""
      img_class = "postimage one"
      img = ""
      fancy_caption = alt
      fancy_data = " "
      full_img_path = ""

      # Attempt to parse the JSON if any is passed in
      begin
        if( !@input.nil? && !@input.empty? )
          jdata = JSON.parse(@input)
          if( jdata.key?("alt") )
            alt = jdata["alt"].strip
            fancy_caption = alt
          end
          if( jdata.key?("img_class") )
            img_class = jdata["img_class"].strip
          end
          if( jdata.key?("fancy-caption") )
            fancy_caption = jdata["fancy_caption"].strip
          end
          if( jdata.key?("fancy-data") )
            fancy_data = jdata["fancy_data"].strip
          end
          img = jdata["img"].strip
        end
      rescue
      end

      # Accessing the page/site variables
      baseurl = "#{lookup(context, 'site.baseurl')}"
      img_dir = "#{lookup(context, 'site.image_dir')}"
      full_img_path = (baseurl+img_dir+img).tr_s("//","/")

      # Create the HTML output for the image container
      output =  "<a href=\"#{full_img_path}\" data-fancybox=\"#{fancy_data}\" data-caption=\"#{fancy_caption}\">"
      output += "<img src=\"#{full_img_path}\" alt=\"#{alt}\" class=\"#{img_class}\">"
      output += "</a>"

      return output    
    end

  end
end
Liquid::Template.register_tag('lightimg', Jekyll::ImageInLightbox)