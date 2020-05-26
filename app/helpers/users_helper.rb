module UsersHelper
  def header_icon_image_present?(account)
    if account.present? && account.icon_image.present?
      image_tag account.icon_image.url, class: "user__mypage--icon"
    else
      image_tag "member_photo_noimage.png", class: "user__mypage--icon"
    end
  end

  def tab_icon_image_present?(account)
    if account.present? && account.icon_image.present?
      image_tag account.icon_image.url, class: "user__mypage--big--icon"
    else
      image_tag "member_photo_noimage.png", class: "user__mypage--big--icon"
    end
  end

  def tab_background_image_present?(account)
    if account.present? && account.background_image.present?
      image_tag account.background_image.url, class: "mypage__background"
    else
      image_tag "user-background.jpg", class: "mypage__background"
    end
  end

  def mypage_icon_image_present?(account)
    if account.present? && account.icon_image.present?
      image_tag account.icon_image.url, class: "mypage-user-icon-image"
    else
      image_tag "member_photo_noimage.png", class: "mypage-user-icon-image"
    end
  end

  def mypage_background_image_present?(account)
    if account.present? && account.background_image.present?
      image_tag account.background_image.url, class: "content_image"
    else
      image_tag "user-background.jpg", class: "content_image" 
    end
  end
end
