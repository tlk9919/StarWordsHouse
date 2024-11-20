//目前所写的页面
import { router } from '@kit.ArkUI'
import { issueAnswerUI } from './IssueAnswerUI'

class PageUrl{
  pageName:string
  url:string

  constructor(  pageName:string,url:string) {
    this.pageName=pageName
    this.url=url
  }
}
//统一卡片样式
@Styles
function card() {
  .width('80%')
  .padding(10)
  .backgroundColor(Color.Pink)
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

  //创建一个数组存放目前写的目录
private currentPage:Array<PageUrl>=[
  new PageUrl('问答界面','pages/IssueAnswerUI'),
  new PageUrl('登录注册界面', 'pages/RegisterLogin'),
  new PageUrl('忘记密码界面', 'pages/RecoverPassword'),
  new PageUrl('欢迎界面', 'pages/WelcomePage'),

]

  build() {
    //底部导航栏
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Column(){
          Text('current Pages:')
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
            .height(80)
          List(){
            ForEach(
              //数组
              this.currentPage,
              (itemPage:PageUrl,index)=>{
                ListItem(){
                  //
                  currentPage(itemPage,index+1)
                }
              }
            )
          }
          .layoutWeight(1)
          .alignListItem(ListItemAlign.Center)//ListItemAlign 是用于列表项对齐的属性

        }
        }.tabBar(this.TabTitle('关心', $r('app.media.tab01_care'), $r('app.media.tab01_care_active'),0))

      TabContent() {
        issueAnswerUI()

      }
      .tabBar(this.TabTitle('问答', $r('app.media.tab02_issueAns'), $r('app.media.tab02_issue_active'), 1))

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

@Builder
function  currentPage(r:PageUrl ,i:number){
Row(){
  Text(i+'.')
    .fontSize(20)
    .fontColor(Color.White)
  Blank()
  Text(r.pageName)
    .fontSize(20)
    .fontColor(Color.White)
}
.margin(10)
.card()
.onClick(()=>{
  //router跳转
  router.pushUrl(
    {
      url:r.url,
      params:{id:i}
    },
    //跳转模式
    router.RouterMode.Single,
    //失败的回调
    err=>{
      if (err) {
        console.log(`路由失败 errCode:${err.code} ,errMsg:${err.message}`)
      }
    }
  )
})
}