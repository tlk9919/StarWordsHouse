import { bloodVolume } from './bloodVolume'
import { moodDiary } from './moodDiary';
import { moodDiary2 } from './moodDiary2';

@Entry
@Component
struct main {
  @State selectedGender: string = '' // 存储选中的性别
  @State currentIndex: number = 0
  @Provide NowTime: Date = new Date(); // 当前日期
  build() {
      Column(){
        Tabs({barPosition:BarPosition.End}){
          //
          TabContent(){
            bloodVolume()
          }.tabBar(this.TabTitle('经期血量',$r('app.media.tab_record01'),0))
          TabContent(){
            moodDiary()
          }.tabBar(this.TabTitle('心情日记',$r('app.media.tab_record01'),1))
          TabContent(){
            moodDiary2()
          }.tabBar(this.TabTitle('身体状况',$r('app.media.tab_record01'),2))
        }
        .onChange((index)=>{
          this.currentIndex=index
        })
      }
      .width('100%')
      .height('100%')
      .backgroundImage($r('app.media.bg_record'))
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