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
  
 
  def draw_progress_bar(max, our, opp, result)
    our_perc = (our.to_f/max.to_f)*100
    opp_perc = (opp.to_f/max.to_f)*100
    # debugger
    colour = case result[0].upcase
      when "W"
        '#46a546'
      when "L" 
        '#C43C35'
      when "D" 
        '#F89406'
      else
        '#BFBFBF'
      end
    our_out = "<div style='float:left;width: #{our_perc}%; height:20px; background-color: #{colour}; text-align:center'>Our</div>"
    opp_out = "<div style='float:left;width: #{opp_perc}%; height:20px; background-color: #{colour}; text-align:center'>Opp</div>"
    output = our_out + opp_out
    return output.html_safe
    
  end

end
