module UsersHelper
  def header_icon_image_present?(account)
    if account&.icon_image.present?
      image_tag account.icon_image.url, class: "user__mypage--icon"
    else
      image_tag "member_photo_noimage.png", class: "user__mypage--icon"
    end
  end

  def evaluations_user_icon_image(account)
    if account&.icon_image.present?
      image_tag account.icon_image.url, height:"50px", width: "50px", class: "user__liked__item__image"
    else
      image_tag "member_photo_noimage.png", height:"50px", width: "50px", class: "user__liked__item__image"
    end
  end

  def tab_icon_image_present?(account)
    if account&.icon_image.present?
      image_tag account.icon_image.url, class: "user__mypage--big--icon"
    else
      image_tag "member_photo_noimage.png", class: "user__mypage--big--icon"
    end
  end

  def tab_background_image_present?(account)
    if account&.background_image.present?
      image_tag account.background_image.url, class: "mypage__background"
    else
      image_tag "user-background.jpg", class: "mypage__background"
    end
  end

  def mypage_icon_image_present?(account)
    if account&.icon_image.present?
      image_tag account.icon_image.url, class: "mp-content__user_info--icon_img"
    else
      image_tag "member_photo_noimage.png", class: "mp-content__user_info--icon_img"
    end
  end

  def mypage_background_image_present?(account)
    if account&.background_image.present?
      image_tag account.background_image.url, class: "mp-content__background_img"
    else
      image_tag "user-background.jpg", class: "mp-content__background_img"
    end
  end

  def fullname(user)
    user.last_name + "　" + user.first_name 
  end

  def fullname_kana(user)
    user.last_name_kana + "　" + user.first_name_kana
  end

end
