@Builder
export function submitIssue() {
  Column(){
    Row() {
      TextInput({ placeholder: '向我提问吧' })
        .width('80%')
        .height(50)
        .margin({ bottom: 15 })
        .caretColor('#b44444') //光标颜色
        .borderWidth(2)
        .borderColor('#a43c58')
      Button() {
        Image($r('app.media.send'))
          .width(50)
          .height(50)
          .borderRadius(25)
          .backgroundColor('#e48494')
          .padding(8)
      }
      //事件
      .onClick(() => {
      })
    }
  }
}