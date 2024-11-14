@Entry

@Component

struct bindsheet {

  //面板高度
  @State sheetHeight:number = 800;
  @State isShow: boolean = false;



  @Builder

  myBuilder() {

    Column() {

      Text('Hello Word')

        .fontSize(50)

        .fontWeight(FontWeight.Bold)

        .margin(10)

    }

  }



  build() {

    Row() {

      Column() {

        // 头像图片
        Image($r('app.media.avatar'))
          .width(60)
          .height(60)
          .position({ x: 0, y: -30 })  // 定位到左上角
          .onClick(() => {
            this.isShow = true;
          })
          .bindSheet($$this.isShow, issueDetail(), {
            height: this.sheetHeight,
            backgroundColor: Color.White,
            blurStyle:BlurStyle.Thick,
            showClose:true,
            title:{title:"title", subtitle:"subtitle"},
          })

        Button("打开bindsheet弹窗")

          .onClick(() => {

            this.isShow = true

          })

          .fontSize(20)

          .margin(10)

      }

      .width("100%")

      .height("100%")

    }.width("100%")

    .backgroundColor("#ff578ddd")

  }

}
@Builder function issueDetail() {
  Column() {
    Text('待补充')
      .fontSize(30)
  }
  .width('100%')
  .height('100%')
}
