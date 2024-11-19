import {PrivacyPolicyDialog} from '../view/welcome/PrivacyPolicyDialog'
@Entry
@Component
struct WelcomePage {
controller:CustomDialogController=new CustomDialogController({
  builder:PrivacyPolicyDialog()
})

  aboutToAppear(): void{
  this.controller.open()
  }
  build() {
      Column() {

        Column(){
          //图片
          Image($r("app.media.welcome01")).width(260)
          Image($r('app.media.welcome02')).width(260)
        }
        .layoutWeight(1)

        //文字描述
        Row(){
          Text('星语小屋支持').opacity(0.5)
          Text('iPv6').opacity(0.5)
            .border({style:BorderStyle.Solid,width:1,color:Color.Gray,radius:10})
            .padding({left:5,right:5})
          Text('网络').opacity(0.5)
        }

    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('')
  }
}