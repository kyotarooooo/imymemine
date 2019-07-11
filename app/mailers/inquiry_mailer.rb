class InquiryMailer < ActionMailer::Base
	default from: "kentaro.inoue.kyotarooooo.0916@gmail.com"   # 送信元アドレス
  default to: "kentaro.inoue.kyotarooooo.0916@gmail.com"     # 送信先アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:subject => 'お問い合わせを承りました')
  end
end
