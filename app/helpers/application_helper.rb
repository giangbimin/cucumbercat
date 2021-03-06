module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      class_notice = bootstrap_class_for(msg_type.to_sym)
      concat(content_tag(:div, message, class: "alert #{class_notice} fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def chat_format_time(time)
    time.strftime('%Y/%m/%d') + ' at ' + time.strftime('%H:%M')
  end
end
