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
          Text('免密登陆')
            .fontSize(20)
          //事件
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        Row(){
          Text('188****8888')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }

        Column(){
          Button('本机号码一键登录')
            .backgroundColor("#ecc4f4")
            .type(ButtonType.Normal)
            .fontSize(20)
            .width(320)
            .height(60)
        }

        .justifyContent(FlexAlign.Center)
        .margin({top:10,bottom:350})
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
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height("100%")
    .backgroundColor("#ecc4f4")
  }
}