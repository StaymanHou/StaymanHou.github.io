module Jekyll
  class Amazon < Liquid::Tag
    def render(context)
      %(<iframe src="http://rcm-na.amazon-adsystem.com/e/cm?t=stahoublo-20&o=1&p=9&l=ez&f=ifr&f=ifr&linkID=ZG3SDYE6AX6Y6KTY" width="180" height="150" scrolling="no" marginwidth="0" marginheight="0" border="0" frameborder="0" style="border:none;"></iframe>)
    end
  end
end
 
Liquid::Template.register_tag('amazon', Jekyll::Amazon)
