module MatchesHelper

  def label_result(result)
    result = result[0].upcase
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

  # Checks result against word, e.g. "Won" against "Won" and returns formatted span
  def span_result(result, word)
    if result == word
      result_short = result[0].upcase
      label_style = case result_short
        when "W"
          "success"
        when "L"
          "important"
        when "D"
          "warning"
        else 
          "default"
        end
        return "<span class='label #{label_style}'>#{word}</span>".html_safe
      else                                                         
        return "<span class='label default'>#{word}</span>".html_safe
      end
  end

end
