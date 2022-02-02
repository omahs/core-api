module ResponseHelper
  def response_json
    JSON.parse(response.body)
  end

  def response_body
    JSON.parse(response.body, object_class: OpenStruct)
  end

  def keys_for(object, child_key)
    object[child_key].to_h.keys
  end
end
