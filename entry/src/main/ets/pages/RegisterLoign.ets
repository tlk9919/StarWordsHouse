//统一卡片样式
@Styles
function card() {
  .width('80%')
  .padding(10)
  .backgroundColor(Color.White)
  .borderRadius({topLeft: 0, topRight: 15, bottomRight: 15, bottomLeft: 15})
  .shadow({
    radius: 6,
    color: '#1F000000',
    offsetX: 2,
    offsetY: 4
  })
}

@Entry
@Component
struct  indexHome {
  //标记
  @State currentIndex: number = 0

  build() {
    //底部导航栏
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Text('关心')
      }.tabBar(this.TabTitle('关心', $r('app.media.tab01_care'), $r('app.media.tab01_care_active'),0))

      TabContent() {
        Text('问答')
      }.tabBar(this.TabTitle('问答', $r('app.media.tab02_issueAns'), $r('app.media.tab02_issue_active'), 1))

      TabContent() {
        Text('更多')
      }.tabBar(this.TabTitle('更多', $r('app.media.tab03_more'), $r('app.media.tab03_more_active'), 2))

      TabContent() {
        Text('日历')
      }.tabBar(this.TabTitle('日历', $r('app.media.tab04_calendar'), $r('app.media.tab04_calendar_active'), 3))
    }
    .width('100%')
    .height('100%')
    //监听
    .onChange((index)=>{
      this.currentIndex=index
    })
  }

  @Builder
  TabTitle(title: string, imageActive: ResourceStr, image:ResourceStr,index: number) {
    Column({ space: 4 }) {
      Image(this.currentIndex === index ? image : imageActive)
        // .fillColor(this.currentIndex === index ? '#ecc4f4' : '#e0dcdc')//好像不支持

        .width(42)
      Text(title)
        .fontColor(this.currentIndex === index ? '#0491d1' : '#8a8a8a')
        .fontSize(14)
    }
  }
}
