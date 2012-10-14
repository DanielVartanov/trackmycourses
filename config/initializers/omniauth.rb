Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "zAUr8Ef70OFhu5zp23r8A", "iF6b03pASWDfliAkcwub9GF21nTVt3vgu53KgNhQRs4"
  provider :facebook, "441724185874097", "e20ac77ef692bd0a7a49c05e2ac998d4"
end
