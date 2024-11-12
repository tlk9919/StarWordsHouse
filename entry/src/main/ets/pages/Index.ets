@Entry
@Component
struct  register {

  build() {
    Column({ space: 10 }) {
      Row() {
        Image($r('app.media.ic_public_back'))
          .width(30)
        //点击返回事件
      }
      .width('100%')

      //注册
      Row() {
        Text('欢迎注册')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 30 })
      }
      .width('100%')
      Row() {
        Text('未注册的手机号将自动创建为账号')
          .fontSize(14)
      }.width('100%')
      Column({space:15}){
        Row() {
          Text('账号密码')

            .fontSize(20)
          //执行事件
          Text('免密登录')

            .fontSize(20)
          //事件
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        Column(){
          Row(){
            Text('账号：')
          }
          .width('100%')
          TextInput({ placeholder: '请输入用户名/邮箱/账号' })
            .margin({top:15})

          Row(){
            Text('密码：')
          }
          .margin({top:15})
          .width('100%')
          TextInput({ placeholder: '请输入密码(6-20个数字和字母)' })
            .margin({top:15})
            .type(InputType.Password)

        }
        .margin({top:60})

        Row() {
          Text('手机号登录')
            .fontSize(15)
          //执行事件
          Text('忘记密码')
            .fontSize(15)
          //事件
        }
        .margin({top:20})
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        Column(){
          Button('登录')
            .borderRadius(10)
            .backgroundColor("#ecc4f4")
            .type(ButtonType.Normal)
            .fontSize(20)
            .width(320)
            .height(60)
        }

        .margin({top:100})
        Row(){
          Checkbox()
            .selectedColor('#ecc4f4')
          Text('已阅读并同意')
          Text('《服务条款》')
            //事件
            .onClick(()=>{

            })
            .fontColor('#4c74fc')
          Text('和')
          Text('《隐私权政策》')
            //事件
            .onClick(()=>{

            })
            .fontColor('#4c74fc')
        }
        .justifyContent(FlexAlign.SpaceAround)


      }
      .margin({left:10,right:10})
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height("100%")
    .backgroundColor("#ecc4f4")
  }
}