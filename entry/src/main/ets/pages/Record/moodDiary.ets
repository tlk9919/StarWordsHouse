@Component
export struct  moodDiary{
  @Consume NowTime: Date
  @Styles normalStyle(){
    .rotate({angle:0})
    .scale({x:1, y: 1})
  }
  @Styles pressedStyle() {
    .rotate({angle:180})
    .scale({x: 0, y: 0})
  }
  @Styles Animation(){
  }
  build() {
    Column({space:20}){
      //日期
      Row({space:10}){
        Text('日期').fontSize(10)
        Text( this.NowTime.toLocaleDateString('zh-CN', {
          weekday: 'long',   // 显示星期几
          year: 'numeric',   // 显示年份
          month: 'long',     // 显示月份
          day: 'numeric'     // 显示日期
        })).fontSize(10)
      }.width('80%').justifyContent(FlexAlign.Start)
      //选择心情
      Row(){
        Stack(){
          Text('选择心情').margin({right: 70})
          Divider().color('#FFEB3B').strokeWidth('30px') .width('18%').position({x:2,y:10}).opacity(0.5)
        }
      }.width('80%').justifyContent(FlexAlign.Start)
      // 兔子心情
      Row(){
        Column(){
          Image($r('app.media.record_mood_happy')).width('22%')
            .stateStyles({
              normal: this.normalStyle,
              pressed: this.pressedStyle,
            })
            .animation({ duration:1000 })
          Text('开心')
        }
        Column(){
          Image($r('app.media.record_mood_excited')).width('20%')
            .stateStyles({
              normal: this.normalStyle,
              pressed: this.pressedStyle,
            })
            .animation({ duration:1000 })
          Text('兴奋')
        }
        Column(){
          Image($r('app.media.record_mood_heartbeat')).width('25%')
            .stateStyles({
              normal: this.normalStyle,
              pressed: this.pressedStyle,
            })
            .animation({ duration:1000 })
          Text('心动')
        }
      }.width('80%').justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Column(){
          Image($r('app.media.record_mood_said')).width('25%')
            .stateStyles({
              normal: this.normalStyle,
              pressed: this.pressedStyle,
            })
            .animation({ duration:1000 })
          Text('伤心')
        }
        Column(){
          Image($r('app.media.record_mood_exhausted')).width('20%')
            .stateStyles({
              normal: this.normalStyle,
              pressed: this.pressedStyle,
            })
            .animation({ duration:1000 })
          Text('疲惫')
        }
        Column(){
          Image($r('app.media.record_mood_angry')).width('20%')
            .stateStyles({
              normal: this.normalStyle,
              pressed: this.pressedStyle,
            })
            .animation({ duration:1000 })
          Text('生气')
        }
      }.width('80%').justifyContent(FlexAlign.SpaceBetween)
      //想说的话
      TextInput({ placeholder: '写点什么想说的话~' })
        .width('80%')
        .height('35%')
        .padding({ bottom:'400px' })
    }
  }
}