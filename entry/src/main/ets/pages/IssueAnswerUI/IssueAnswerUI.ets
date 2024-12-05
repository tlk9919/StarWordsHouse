import { Header } from "../../components/components"
import { ChatMessage } from "../../model/getAnswer"
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

  @State issueText: string = '';
  @State chatHistory: ChatMessage[] = [];
  build() {
    Column() {
      //返回图标
      Header()
      //云
      Column(){
        Image($r('app.media.cloud'))
          .height(160)
        //内容
        content({issueText:this.issueText,chatHistory:this.chatHistory})
      }
      //底部面板
      // Panel(this.isShowPanel)
      Blank()
      //提问
      Column(){
        submitIssue({issueText:this.issueText,chatHistory:this.chatHistory})
      }
    }
    .backgroundImage($r('app.media.bg_IssueAnswer'))
    .backgroundImageSize(ImageSize.Cover)
    .backgroundColor('#fccccc')
  }
}


