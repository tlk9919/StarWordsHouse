import {PrivacyPolicyDialog} from '../view/welcome/PrivacyPolicyDialog'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct WelcomePage {
  //获取实例信息
  context=getContext(this) as common.UIAbilityContext
  //声明弹窗
  controller: CustomDialogController = new CustomDialogController({
    builder: PrivacyPolicyDialog({
        confirm:():void=>this.onConfirm()
    })

  })

  onConfirm(){
  //保存首选项


    //跳转首页
  }
  exitApp(){
  //退出
    this.context.terminateSelf()
  }

  aboutToAppear(): void{
  this.controller.open()
  }
  build() {
      Column() {

        Column(){
          //图片
          Image($r("app.media.welcome01")).width(260).interpolation(ImageInterpolation.High)
          Image($r('app.media.welcome02')).width(260).interpolation(ImageInterpolation.High)
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