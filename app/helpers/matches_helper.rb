module MatchesHelper

  def label_result(result)
    case result
    when "W"
      return "success"
    when "L"
      return "important"
    when "D"
      return "warning"
    else 
      return "default"
    end
  end

end
