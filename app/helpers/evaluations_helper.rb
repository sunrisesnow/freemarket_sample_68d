module EvaluationsHelper

  def comment_present?(comment)
    if comment&.present?
      comment
    else
      "お取引ありがとうございました。"
    end
  end

  def which_evaluation?(evaluation)
    case evaluation
    when 1
      icon("fas fa-laugh",class: "good")
    when 2
      icon("fas fa-meh",class: "normal")
    when 3
      icon("fas fa-frown",class: "bad")
    end
  end
end
