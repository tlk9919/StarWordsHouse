import { Header } from "../components/components"

class detail {
  title: string
  clickImage: ResourceStr

  constructor(title: string, clickImage: ResourceStr) {
    this.title = title
    this.clickImage = clickImage
  }
}

//统一卡片样式
@Styles
function card() {
  .margin({ left: 65, top: 10 })
  .width('80%')
  .padding(10)
  .backgroundColor(Color.White)
  .borderRadius({ topLeft: 0, topRight: 15, bottomRight: 15, bottomLeft: 15 })
  .shadow({
    radius: 6,
    color: '#1F000000',
    offsetX: 2,
    offsetY: 4
  })
}

//问答界面样式
@Entry
@Component
struct issueAnswerUI {
  //详细面板标记
  @State isShowPanel:boolean=false
  build() {
    Column() {
      //返回图标
      Header()
      //云
      Image($r('app.media.cloud'))
        .height(160)

      //内容
      content()
      //底部面板
// Panel(this.isShowPanel)
      //问答输入框
      Blank()
      //提问
      submitIssue()

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fccccc')
  }
}

@Component
struct content {
  //底部具体问题弹出面板
  @State isShow: boolean = false
  //面板高度
  @State sheetHeight: number = 800;
  //当前选中的问题
  @State selectedDetail: detail | null = null // 用于保存当前选中的问题
  //标记字体颜色
  @State color: string = '#4c94ec'

  //标记是否显示全部问题
  @State showAll: boolean = false //
  //更新字体颜色标记
  @State selectedIndex: number = -1

  private words: Array<detail> = [
    new detail('怎么改善月经不调', $r("app.media.detailClick")),
    new detail('怎样区分原发和继发性痛经', $r("app.media.detailClick")),
    new detail('经期推迟', $r("app.media.detailClick")),
    new detail('怎样缓解经期痛', $r("app.media.detailClick")),
    new detail('经期提前', $r("app.media.detailClick")),
    new detail('女生第一次来例假时间', $r("app.media.detailClick")),
    new detail('月经回潮', $r("app.media.detailClick"))
  ]

  build() {
    Row() {
      // 头像图片
      Image($r('app.media.avatar'))
        .width(60)
        .height(60)
        .position({ x: 0, y: -30 })  // 定位到左上角
      // 问题文本及内容
      Column({ space: 12 }) {
        Text('小星列出了一些常见问题，不知道能否解决星崽的疑问？')

        // 遍历问题，只显示前三个
        ForEach(
          // 数组
          this.showAll ? this.words : this.words.slice(0, 3),
          (item: detail, index: number) => {
            Row() {
              Text(item.title)
                .fontSize(19)
                .fontColor(this.selectedIndex === index ? '#ff625d5d' : this.color)
                .onClick(() => {
                  this.selectedIndex = index
                  this.selectedDetail = item // 设置当前选择的问题
                  this.isShow = true // 显示弹窗
                })
              Blank()
              Button() {
                Image(item.clickImage)
                  .width(20)
                  .backgroundColor(Color.White)
              }
              //点击事件
              .onClick(() => {
                this.selectedDetail = item
                this.isShow = true
              })
            }
            .width('100%')
          }
        )
        Divider()
        // 查看/收起按钮
        Button() {
          Text(this.showAll ? '收起' : '查看更多')
            .fontSize(16)
            .fontColor('#fccccc')
        }
        .backgroundColor('#f3f9fa')
        .onClick(() => {
          // 切换显示状态，控制是显示全部文本还是前三个
          this.showAll = !this.showAll
        })
      }.card()
    }

    // 弹出详细信息
    .bindSheet($$this.isShow, issueDetail(this.selectedDetail), {
      height: this.sheetHeight,
      backgroundColor: Color.White,
      blurStyle: BlurStyle.Thick,
      showClose: true,
      title: { title: "详细信息", subtitle: this.selectedDetail?.title || "暂无标题" }
    })
  }
}

@Builder function submitIssue() {
  Stack(){
    //兔子

      Image($r('app.media.rabbit'))
        .height('160')
        .position({x:0,y:-150})

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

@Builder function issueDetail(detail: detail | null) {
  Column() {
    if (detail) {
      Text(`问题: ${detail.title}`)
        .fontSize(30)
      Text('详细内容待补充')
        .fontSize(16)
    } else {
      Text('请选择一个问题查看详细信息')
        .fontSize(30)
    }
  }
  .width('100%')
  .height('100%')
}
