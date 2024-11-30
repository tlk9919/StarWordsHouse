@Entry
@Component
struct MenstruationReminder {
  @State avatar: ResourceStr = 'app.media.avatar'
  @State mstNowTime: Date = new Date(); // 当前日期
  @State mstRemainderTime:number=10  // 剩余天数
  // 开始时间
  @State mstStartTime: Date = new Date(this.mstNowTime.getTime() + this.mstRemainderTime * 24 * 60 * 60 * 1000);

  build() {
    Column() {
      // 个人信息头像
      Row() {
        Image($r(this.avatar as string)).width('50%')
      }
      .width('25%')
      .justifyContent(FlexAlign.Center)
      .borderRadius(10)
      .backgroundColor('#b4e4f4')
      .height('6%')  // 设置Row的高度
      .margin({right: '80%', top: '18%'})

      Stack(){
        // 其他内容 (云朵、兔子等)
        Image($r("app.media.bg_menstruation_clouds")).width('100%')
        Column({space:30}) {
          // 格式化日期，显示月、日和星期几
          Text('日期: ' + this.mstNowTime.toLocaleDateString('zh-CN', {
            month: 'long',   // 显示月份
            day: 'numeric',  // 显示日期
            weekday: 'long'  // 显示星期几
          })).fontColor('#a16081')
          Text('下次大姨妈到访时间: 还有' + this.mstRemainderTime + '天' ).margin({top:20}).fontColor('#3e178d').fontSize(20)
          Text('预计开始时间: ' + this.mstStartTime.toLocaleDateString('zh-CN', { month: 'long', day: 'numeric' }))
            .fontColor('#a16081')
        }
      }
      Image($r("app.media.bg_menstruation_rabbits")).width('55%')
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r("app.media.bg_menstruation"))
    .backgroundImageSize(ImageSize.Cover)
  }
}
