@Entry
@Component
struct Index {
  build() {
    Column() {
      Column(){
        Image($r('app.media.tab04_calendar_active'))

          //状态样式
          .stateStyles({
            //变化前图片样式
            normal:
            {
              .width('100%')
            },
            //变化后图片样式（pressed为选中后变化）
            pressed:{
              .width('50%')
            }
          })
            //动画效果
          .animation({
            //转变时间
            duration:1000
          })
          .width('100%')
          .border({width:5,color:'#383838'})
            //圆角
          .borderRadius(40)




          .stateStyles({
            normal:
            {
              .rotate({angle:0})
              .scale({x:1, y: 1})

            },
            pressed:{
              .rotate({angle:180})
              .scale({x: 0, y: 0})

            }

          })

          .animation({
            duration:1000
          })

      }
      .width(300)
      .height(500)
      .backgroundColor('#383838')
      .margin({top:50})
      .padding(5)
      .shadow({radius:50,color:Color.Pink})
    }

    .width('100%')
    .height('100%')
    .backgroundColor('#757575')
  }
}