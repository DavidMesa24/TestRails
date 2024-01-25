module ApplicationHelper
  def flash_class_for(flash_type)
    case flash_type.to_sym
    when :notice
      "bg-green-500 text-white"
    when :alert, :error
      "bg-red-500 text-white"
    else
      "bg-blue-500 text-white"
    end
  end
end
