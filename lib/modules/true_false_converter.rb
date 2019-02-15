module TrueFalseConverter
  CSV::Converters[:true_false_string_to_bool] = lambda{|str|
    if str == "TRUE"
      true
    elsif str == "FALSE"
      false
    else
      str
    end
  }
end
