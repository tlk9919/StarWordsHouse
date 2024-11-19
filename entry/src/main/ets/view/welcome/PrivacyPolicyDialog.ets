@CustomDialog
@Preview
 export  struct PrivacyPolicyDialog {
  controller: CustomDialogController

  build() {
    Column({space:10}) {
      // 标题
      Text($r('app.string.user_privacy_title'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      // 内容
      Text($r('app.string.user_privacy_content'))
      // 按钮
      Button($r('app.string.agree_label')).width(150).backgroundColor('#fccce4')
      Button($r('app.string.refuse_label')).width(150).backgroundColor('#ccd6d4')
    }
    .width('100%')
    .padding(15)
  }
}
