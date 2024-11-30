@Entry
@Component
struct main {
  //标记
  @State currentIndex: number = 0
  @State NowTime: Date = new Date(); // 当前日期
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
    Column(){
      Tabs({barPosition:BarPosition.End}){
        //
        TabContent(){
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
            //血量
            Row(){
           Stack(){
             Text('血量').margin({right: 70})
             Divider().color('#FFEB3B').strokeWidth('30px') .width('10%').position({x:2,y:10}).opacity(0.5)
           }
              Row({space:10}){
                Column(){
                  Image($r('app.media.record_boold_none')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('少')
                }
                Column(){
                  Image($r('app.media.record_boold_normal')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('正常')
                }
                Column(){
                  Image($r('app.media.record_boold_large')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('多')
                }
              }
            }.width('80%').justifyContent(FlexAlign.Start)
            //血色
            Row(){
              Stack(){
                Text('血色').margin({right: 70})
                Divider().color('#FFEB3B').strokeWidth('30px') .width('10%').position({x:2,y:10}).opacity(0.5)
              }
              Row({space:10}){
                Column(){
                  Image($r('app.media.record_bloodColor_less')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('浅')
                }
                Column(){
                  Image($r('app.media.record_bloodColor_normal')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('正常')
                }
                Column(){
                  Image($r('app.media.record_bloodColor_large')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('深')
                }
              }
            }.width('80%').justifyContent(FlexAlign.Start)
            //疼痛程度
            Column({space:30}){
              Stack(){
                Text('疼痛程度').margin({right: 70})
                Divider().color('#FFEB3B').strokeWidth('30px') .width('20%').position({x:2,y:10}).opacity(0.5)
              }
              Row(){
                Column(){
                  Image($r('app.media.record_painLevel_relax')).width('20%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('轻轻松松')
                }
                Column(){
                  Image($r('app.media.record_painLevel_littePain')).width('25%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('有点痛')
                }
                Column(){
                  Image($r('app.media.record_painLevel_superPain')).width('25%')
                    .stateStyles({
                      normal: this.normalStyle,
                      pressed: this.pressedStyle,
                    })
                    .animation({ duration:1000 })
                  Text('超级痛')
                }
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
            }.width('80%').alignItems(HorizontalAlign.Start)
          }

        }.tabBar(this.TabTitle('经期血量',$r('app.media.tab_record01'),0))
        TabContent(){

          Text('2')
        }.tabBar(this.TabTitle('心情日记',$r('app.media.tab_record01'),1))
        TabContent(){

          Text('3')
        }.tabBar(this.TabTitle('身体状况',$r('app.media.tab_record01'),2))
      }
      .onChange((index)=>{
        this.currentIndex=index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg_record_cloud02'))
    .backgroundImageSize(ImageSize.Cover)
  }
  @Builder
  TabTitle(title: string, image:ResourceStr,index: number) {
    Column({ space: 4 }) {
     Stack(){
       Image(image)
         .width('100%')
       Text(title)
         .fontColor(this.currentIndex === index ? '#fce4f4' : '#8a8a8a')
         .fontSize(14)
     }
    }
  }
}