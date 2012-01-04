module DynamicRefresh
  module Chat
    include ActionView::Helpers::JavaScriptHelper

    def refresh_message(container, element)
      %Q{
        $(".chat_window #{container}").append("#{escape_javascript(render_to_string(element))}");
        $(".chat_window #{container}").animate({ scrollTop: $('#{container}').height() }, "slow");
      }
    end
  end
end