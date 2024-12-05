import { CJCalendar, OptMode, SelectedStyle, CJDateItem } from 'cjcalendar'

@Entry
@Component
struct CustomCalendar {
  @State selectedDates: CJDateItem[] = []  // 用于存储选中的日期
  @State currentDate: Date = new Date()    // 当前日期
  @State selectedStyle: SelectedStyle = SelectedStyle.ALONE  // 选中样式
  @State titleFontColor: string = "#252a34"  // 标题字体颜色
  @State weekTitleFontColor: string = "#9E9E9E"  // 星期标题字体颜色
  @State weekTitleBackgroundColor: string = "#FFFFFF"  // 星期标题背景色
  @State selectFontColor: string = "#FFFFFF"  // 选中日期字体颜色
  @State selectItemBgColor: string = "#03A9F4"  // 选中日期背景颜色
  @State showTodayButton: boolean = true  // 是否显示今天快捷按钮
  @State calendarHeight: string = "1200px"  // 设置日历高度
  // @State calendarRatio:  number = 1/1// 设置日历的宽高比
  build() {
    Column({space:15}) {
      Column() {
        CJCalendar({
          optMode: OptMode.RANGE, // 一段时间选择模式
          startDate: new Date(2020, 0, 1), // 设置开始日期
          endDate: new Date(2030, 11, 31), // 设置结束日期
          titleFontColor: this.titleFontColor,
          weekTitleFontColor: this.weekTitleFontColor,
          weekTitleBackgroundColor: this.weekTitleBackgroundColor,
          showFastToday: this.showTodayButton,
        })  .backgroundColor(Color.White)  .borderRadius(10)
      }
      .height(this.calendarHeight)
      .margin({left: 20, right: 20,top:10})
      Row({space:10}){
        Stack(){
          Text('关于大姨妈').margin({right: 70})
          Divider().color('#FFEB3B').strokeWidth('30px') .width('30%').position({x:2,y:10}).opacity(0.5)
        }
        Button('来了').backgroundColor('#e4e4e4')
        Button('没来').backgroundColor('#fc7cbc')
      }.backgroundColor(Color.White).borderRadius(20).width('90%').padding(15)
      Blank()
      //记录
      Row(){
        // 记录按钮
        Button() {
          Image($r('app.media.Calendar_record2'))
            .width(100)
            .height(100)
            .borderRadius(25)
            .padding(8);
        }.backgroundColor('#e7eef8')
        Image($r('app.media.Calendar_rabbis')).width('40%')
      }.width('100%').justifyContent(FlexAlign.SpaceAround)

    }
    .height('100%')
    .borderRadius(10)
    .backgroundImage($r('app.media.bg_calendar02'))
    .backgroundImageSize(ImageSize.Cover)
  }

  // 日期选择变化回调
  onDateChange(selectedDates: CJDateItem[]) {
    this.selectedDates = selectedDates;
    console.log("已选日期：", selectedDates.map(date => `${date.fullYear}-${date.month + 1}-${date.date}`).join(", "));
  }

}
