@CustomDialog
@Preview
export struct PrivacyPolicyDialog {
  controller: CustomDialogController
  confirm: () => void = () => {};  // 默认值为空函数
  cancel: () => void = () => {};

  build() {
    Column({space: 10}) {
      // 标题
      Text($r('app.string.user_privacy_title'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      // 内容
      Text($r('app.string.user_privacy_content'))
      Row(){
        // 按钮
        Button($r('app.string.agree_label')).width(150).backgroundColor('#fccce4')
          .onClick(() => {
            this.confirm()
            this.controller.close()
          })
        Button($r('app.string.refuse_label')).width(150).backgroundColor('#ccd6d4')
          .onClick(() => {
            this.cancel()
            this.controller.close()
          })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

    }

    .width('100%')
    .padding(15)
  }
}
