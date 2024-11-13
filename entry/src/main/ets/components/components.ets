import { router } from "@kit.ArkUI"

@Styles
//背部统一卡片样式
function card(){
  .margin({ left: 10, right: 10 })
  .backgroundColor(Color.White)
  .borderRadius(15)
}
@Component
export  struct  uiTermsStyle {
  build() {
    Row(){
      Checkbox()
        .selectedColor('#ecc4f4')
      Text('已阅读并同意')
      Text('《服务条款》').fontSize(15)
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


}

//返回图标
@Builder export  function  Header() {
  Row() {
    Image($r('app.media.ic_public_back')).width(30)
    // 点击返回事件
      .onClick(()=>{
        router.back()
      })
  }.width('100%')
}

//按钮
@Builder
export  function buttonStyle(buttonName:string){
  Button(buttonName)
    .borderRadius(10)
    .backgroundColor("#ecc4f4")
    .type(ButtonType.Normal)
    .fontSize(20)
    .width(320)
    .height(60)
}
//手机号登录和忘记密码
@Component
export  struct forgetPassword  {
  build() {
    Row() {
      Text('手机号登录')
        .fontSize(15)
        .fontColor('#636e72')
      Text('忘记密码')
        .fontSize(15)
        .fontColor('#636e72')
        .onClick(()=>{
          router.pushUrl(
            {
            url:'pages/RecoverPassword'
          },
            err=>{
              if (err) {
                console.log(`路由失败 errCode:${err.code} ,errMsg:${err.message}`)
              }
            }

          )
        })
    }.margin({ top: 20 }).width('100%').justifyContent(FlexAlign.SpaceAround)
  }
}
//欢迎注册等
@Builder
export function welcome(welcome1:string,tip:string){
  Row() {
    Text(welcome1)
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
      .margin({  top: 30,left: 10, right: 10 })
  }
  .width('100%')
  // 注册说明
  Row() {
    Text(tip)
      .fontColor('#636e72')
      .fontSize(14)
      .margin({ left: 10, right: 10 })
  }.width('100%')
}


@Component
export  struct  freePassLogin {
  @State tellnumber:string='188****8888'
  build() {
    // 免密登录 Tab 内容
    TabContent() {
      // 内容
      Column(){
        Text(this.tellnumber)
          .fontSize(40)
        Column() {
          buttonStyle("手机号一键登录")
        }.margin({ top: 50 })
        uiTermsStyle()
      }.padding({bottom:200})

    }.tabBar('免密登录')
  }
}


