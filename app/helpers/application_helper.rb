module ApplicationHelper
  def flash_class_for(flash_type)
    case flash_type.to_sym
    when :notice
      "bg-green-500 text-white text-center"
    when :alert, :error
      "bg-red-500 text-white text-center"
    else
      "bg-blue-500 text-white text-center"
    end
  end

  def action_paths_for_resource(resource)
    {
      edit: send("edit_v1_#{resource.class.to_s.downcase}_path", resource),
      delete: send("v1_#{resource.class.to_s.downcase}_path", resource)
    }
  end
end
