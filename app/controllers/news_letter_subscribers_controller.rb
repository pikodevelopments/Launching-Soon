class NewsLetterSubscribersController < ActionController::Base
  
  skip_before_filter :setup_launching_soon_page

  def index
    @css_file = ::LAUNCHING_SOON_CONFIG[:css_file_name]
    @launching_date = if Time.zone
                        Time.zone
                      else
                        Time
                      end.parse(::LAUNCHING_SOON_CONFIG[:launching_date]).utc
    render :template => File.join('launching_soon', ::LAUNCHING_SOON_CONFIG[:html_file_name]), :layout => "launching_soon"
  end
  
  
  # This will write a valid email address to LAUNCHING_SOON_CONFIG[:csv_file_name] file (eg. public/data.csv).
  def create
    @nls = LaunchingSoon::NewsLetterSubscriber.new(:email => params[:email])
    respond_to do |format|
      format.html { render :nothing => true }
      format.js do
        render :update do |page|
          page.replace_html "message", @nls.save ? render_success_message : render_error_message
        end
      end
    end
  end
  
end
