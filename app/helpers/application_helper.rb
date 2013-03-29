module ApplicationHelper

  # URLs
  CIW_FACEBOOK_URL     = 'https://www.facebook.com/ChicagoIdeasWeek'
  CIW_TWITTER_URL      = 'https://twitter.com/chicagoideas'
  CIW_LINKEDIN_URL     = 'www.linkedin.com/company/chicago-ideas-week'
  CIW_GPLUS_URL        = 'https://plus.google.com/113007296557109921813/posts'
  CIW_BLOG_URL         = 'http://blog.chicagoideas.com/'
  CIW_YOUTUBE_URL      = 'http://www.youtube.com/user/ChicagoIdeasWeek'
  SUPPORT_YOUTUBE_URL  = 'http://www.youtube.com/embed/Ctd7kAZrW6I'
  HOMEPAGE_YOUTUBE_URL = 'http://www.youtube.com/embed/OU9zZKFD9TQ'

  # GOOGLE DOCS
  LABS_DOC_URL         = 'https://docs.google.com/spreadsheet/viewform?formkey=dG5EZTFJTV81Y1VUdFFHeGp6V3hsdUE6MQ'
  NOMINATE_FELLOW_URL  = 'https://docs.google.com/spreadsheet/viewform?formkey=dGVKZGJmY1FsZUxsZ3UxRkE3Y1VQbXc6MQ#gid=0'

  # EMAILS
  CIW_MEMBERSHIP_EMAIL = 'membership@chicagoideas.com'
  CIW_FORMS_EMAIL      = 'forms@chicagoideas.com'
  CIW_BHSI_SUBM_EMAIL  = 'bhsi_submissions@chicagoideas.com'
  CIW_KELLY_EMAIL      = 'kelly@chicagoideas.com'
  CIW_INFO_EMAIL       = 'info@chicagoideas.com'
  CIW_LEAH_EMAIL       = 'leah@chicagoideas.com'
  CIW_JESSICA_EMAIL    = 'jessica@chicagoideas.com'
  CIW_COREY_EMAIL      = 'corey@chicagoideas.com'
  CIW_BECKY_EMAIL      = 'becky@chicagoideas.com'
  DAVID_EMAIL          = 'david@davidburstein.com'
  LEANDRO_EMAIL        = 'leandro@meetmantra.com'
  MARTIN_EMAIL         = 'martin@meetmantra.com'
  FRANK_EMAIL          = 'frank@meetmantra.com'
  MAYBELLE_EMAIL       = 'maybelle@meetmantra.com'
  TK_SHOPCLASS_EMAIL   = 'tk@shopclass.co'
  INFO_BLUHMHELF_EMAIL = 'info@bluhmhelfand.com'

  BHSI_RECIPIENTS      = case Rails.env
                         when "production"
                          "#{CIW_JESSICA_EMAIL}, #{CIW_COREY_EMAIL}, #{DAVID_EMAIL}"
                        when "staging"
                          "#{CIW_JESSICA_EMAIL}, #{CIW_COREY_EMAIL}, #{DAVID_EMAIL}, #{LEANDRO_EMAIL}, #{MARTIN_EMAIL}, #{FRANK_EMAIL}, #{MAYBELLE_EMAIL}"
                        else
                          "#{LEANDRO_EMAIL}, #{MARTIN_EMAIL}"
                        end
  BHSI_CCO = "#{LEANDRO_EMAIL}, #{MARTIN_EMAIL}, #{FRANK_EMAIL}, #{MAYBELLE_EMAIL}"
  DAILY_REPORT_RECIPIENTS = case Rails.env
                            when "production"
                              CIW_BECKY_EMAIL
                            when "staging"
                              "#{LEANDRO_EMAIL}, #{MARTIN_EMAIL}"
                            else
                              "#{LEANDRO_EMAIL}, #{MARTIN_EMAIL}"
                            end
  MEMBER_PURCHASE_RECIPIENTS = case Rails.env
                               when "production"
                                 CIW_MEMBERSHIP_EMAIL
                               when "staging"
                                 "#{LEANDRO_EMAIL}, #{MARTIN_EMAIL}"
                               else
                                 "#{LEANDRO_EMAIL}, #{MARTIN_EMAIL}"
                               end

  def conditional_html( lang = "en", &block )
    fb_meta = "xml:lang='en' xmlns:fb='http://www.facebook.com/2008/fbml' xmlns:og='http://opengraphprotocol.org/schema/' xmlns='http://www.w3.org/1999/xhtml'"
    haml_concat Haml::Util::html_safe <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]><html lang="#{lang}" class="no-js ie6" #{fb_meta}> <![endif]-->
      <!--[if IE 7 ]><html lang="#{lang}" class="no-js ie7" #{fb_meta}> <![endif]-->
      <!--[if IE 8 ]><html lang="#{lang}" class="no-js ie8" #{fb_meta}> <![endif]-->
      <!--[if IE 9 ]><html lang="#{lang}" class="no-js ie9" #{fb_meta}> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}" class="no-js" #{fb_meta}> <!--<![endif]-->
    HTML
    haml_concat capture( &block ) << Haml::Util::html_safe( "\n</html>" ) if block_given?
  end

  # Simple way to truncate a paragraph
=begin
  def truncate_words(text, length = 250, end_string = ' ...')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
=end

  def truncate_words text, length=55, truncate_string="..."
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end

  def truncate_words text, length=55, separator = ' ', truncate_string = '...'

  end

  def truncate_words(text, length = 30, separator = ' ', truncate_string = '...')
    return if text.nil?
    truncated_text = text.split[0..length].join(separator)
    if(truncated_text == text)
      text
    else
      truncated_text + ' ' + truncate_string
    end
  end



  # a robust method to display flash messages
  def flash_helper keys=[:notice, :alert]
    # allow keys to be a symbol or an array of symbols
    keys = [keys] unless keys.kind_of? Array

    # html from each message
    html = ''
    flash.each do |key, msg|
      html = html + content_tag(:div, msg, :class => key) if keys.index key
    end
    html.html_safe
  end

  # a convinience method to render the breadcrumbs template
  def breadcrumbs base_model, reload_on_success=false
    render "shared/breadcrumbs_item", :base_model => base_model
  end

  # a page title which gracefully degrades
  def page_title
    if @page_title
      "#{@page_title} | Chicago Ideas Week"
    elsif params[:page_title]
      "#{params[:page_title]} | Chicago Ideas Week"
    else
      "#{params[:controller].split('/').last.singularize.titlecase} #{section_title} | Chicago Ideas Week"
    end
  end

  # a wrapper for @section_title, which gracefully degrdes to a presentable form of the current action name
  def section_title
    @section_title || params[:action].titlecase
  end

  # creates a span for an icon sprite (jquery ui)
  def icon name, subset=nil
    css_class = "ui-icon ui-icon-#{name}"
    css_class += " ui-icon-#{subset}" if subset
    content_tag(:span, nil, :class => css_class)
  end

  # return 'active' if the current controller action matches the provided action_name
  def active_for action_name
    params[:action].to_s == action_name.to_s ? 'active' : ''
  end

  # return 'active' if the current controller name matches the provided controller_name
  def active_for_controller controller_name
    params[:controller].to_s == controller_name.to_s ? 'active' : ''
  end

  # return 'active' if the current controller and action name matches the provided controller_name and action_name
  def active_for_controller_and_action controller_name, action_name
    params[:controller].to_s == controller_name.to_s && params[:action].to_s == action_name.to_s ? 'active' : ''
  end

  #  string representation of how long ago an object was created, or 'never' if the object doesnt exist
  def created_ago_or_never m
    return 'never' unless m.present?
    return m.created_at.to_s(:ago)
  end

  def member_type_price(member_type)
    price_str = number_to_currency(member_type.min_price, :precision => 0)
    unless member_type.has_fixed_price?
      price_str += " - #{ number_to_currency(member_type.max_price, :precision => 0) }"
    end
    price_str
  end

  def opts_for_amount(order)
    hash = { :as => :string, :required => true, :hint => "Enter the amount you wish to contribute. (Minimum: #{ number_to_currency(order.member_type.min_price) }, Maximum: #{ number_to_currency(order.member_type.max_price) })" }
    if order.member_type.has_fixed_price?
      hash.merge!({ :hint => "You will be charged for #{ number_to_currency(order.member_type.max_price) }", :input_html => { :value => order.member_type.max_price } })
    end
    hash
  end

  def word_count_container(id)
    content_tag :p, :class => 'word_count_container' do
      content_tag :span do
        raw(
          'Total word count: ' +
          content_tag(:span, 0, :id => id)
        )
      end
    end
  end

  def same_billing_info_radios
    content_tag :li, :class => 'radio input required', :id => 'same_billing_info' do
      content_tag :fieldset, :class => 'choices' do
        content = content_tag :legend, :class => 'label' do
          content_tag :label, 'Personal info same as billing'
        end
        content += content_tag :ol, :class => 'choices' do
          li_items = content_tag :li, :class => 'choice' do
            label_tag :same_info_Yes do
              raw(
                'Yes' +
                radio_button_tag(:same_info, 'Yes')
              )
            end
          end
          li_items += content_tag :li, :class => 'choice' do
            label_tag :same_info_No do
              raw(
                'No' +
                radio_button_tag(:same_info, 'No', true)
              )
            end
          end
        end
      end
    end
  end

end
