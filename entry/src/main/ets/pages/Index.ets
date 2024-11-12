@Entry
@Component
struct Register {
  build() {
    Column({ space: 10 }) {
      // 返回键位
      this.Header()

      // 注册标题
      Row() {
        Text('欢迎注册')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({  top: 30,left: 10, right: 10 })

      }
      .width('100%')
      // 注册说明
      Row() {
        Text('未注册的手机号将自动创建为账号')
          .fontColor('#636e72')
          .fontSize(14)
          .margin({ left: 10, right: 10 })
      }.width('100%')

      Column({ space: 10 }) {
        //导航
        Tabs() {
          // 账号密码 Tab 内容
          TabContent() {
            Column({ space: 15 }) {
              Row() {
                Text('账号：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              TextInput({ placeholder: '请输入用户名/邮箱/账号' })
                .fontColor('#dcdce3')
                .margin({ top: 10 })

              Row() {
                Text('密码：').fontSize(16).fontWeight(FontWeight.Bold)
              }.width('100%')

              TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
                .fontColor('#dcdce3')
                .margin({ top: 10 })
                .padding(10)
                .type(InputType.Password)

              // 手机号登录与忘记密码
              Row() {
                Text('手机号登录')
                  .fontSize(15)
                  .fontColor('#636e72')
                Text('忘记密码')
                  .fontSize(15)
                  .fontColor('#636e72')
              }.margin({ top: 20 }).width('100%').justifyContent(FlexAlign.SpaceAround)

              // 登录按钮
              Column() {
                Button('登录')
                  .borderRadius(10)
                  .backgroundColor("#ecc4f4")
                  .type(ButtonType.Normal)
                  .fontSize(20)
                  .width(320)
                  .height(60)
              }.margin({ top: 20 })

              // 服务条款与隐私政策
              Row() {
                Checkbox().selectedColor('#ecc4f4')
                Text('已阅读并同意')
                Text('《服务条款》')
                  .fontColor('#4c74fc')
                  //事件
                  .onClick(() => {})
                Text('和')
                Text('《隐私权政策》')
                  .fontColor('#4c74fc')
                  //事件
                  .onClick(() => {})
              }.justifyContent(FlexAlign.SpaceAround)
            }
            .padding({bottom:200})
          }
          .tabBar('账号密码')

          // 免密登录 Tab 内容
          TabContent() {
            // 内容
          }.tabBar('免密登录')
        }
      }
      .margin({ left: 10, right: 10 })
      .backgroundColor(Color.White)
      .borderRadius(15)
      .shadow({
        radius: 6,
        color: '#1F000000',
        offsetX: 2,  // 阴影在 X 轴上向右偏移 2 像素
        offsetY: 4   // 阴影在 Y 轴上向下偏移 4 像素
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ecc4f4")

  }

  @Builder Header() {
    Row() {
      Image($r('app.media.ic_public_back')).width(30)
      // 点击返回事件
    }.width('100%')
  }
}
