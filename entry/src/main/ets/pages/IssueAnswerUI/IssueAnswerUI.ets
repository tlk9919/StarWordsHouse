import { Header } from "../../components/components"
import {content, } from "../../view/IssueAnswer/Coentent"
import { submitIssue } from "../../view/IssueAnswer/submitIssue"

//统一卡片样式
@Styles
function card() {
  .margin({ left: 65, top: 10 })
  .width('80%')
  .padding(10)
  .backgroundColor(Color.White)
  .borderRadius({ topLeft: 0, topRight: 15, bottomRight: 15, bottomLeft: 15 })
  .shadow({
    radius: 6,
    color: '#1F000000',
    offsetX: 2,
    offsetY: 4
  })
}

//问答界面样式
@Entry
@Component
export  struct  issueAnswerUI {
  //详细面板标记
  @State isShowPanel:boolean=false
  build() {
    Column() {
      //返回图标
      Header()
      //云
     Column(){
       Image($r('app.media.cloud'))
         .height(160)

       //内容
       content()
     }
     .layoutWeight(1)
      //底部面板
      // Panel(this.isShowPanel)
      //问答输入框
      Image($r('app.media.rabbit'))
        .height('160')
        .margin({right:120})

      Blank()
      //提问
      submitIssue()

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fccccc')
  }
}



