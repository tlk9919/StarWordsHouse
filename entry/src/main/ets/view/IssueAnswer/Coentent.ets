import { ChatMessage } from '../../model/getAnswer';
import { detail } from '../../model/IssueAnswerdetail';
import { issueDetail } from './issueDetail';

//统一卡片样式
@Styles
function card() {
  .margin({ left: 65, top: 50 })
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
@Component
export struct content {
  // 底部具体问题弹出面板
  @State isShow: boolean = false
  // 面板高度
  @State sheetHeight: number = 800;
  // 当前选中的问题
  @State selectedDetail: detail | null = null // 用于保存当前选中的问题
  // 标记字体颜色
  @State color: string = '#4c94ec'
  // 标记是否显示全部问题
  @State showAll: boolean = false //
  // 更新字体颜色标记
  @State selectedIndex: number = -1

  @Link issueText: string
  @Link chatHistory: ChatMessage[]

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
    Column() {
      // 组合头像和问题
      List() {
        // 将原有的头像和问题包装在 ListItem
        ListItem() {
          Row() {
            // 头像图片
            Image($r('app.media.avatar'))
              .width(60)
              .height(60)
              .position({ x: -70, y: -50 })  // 定位到左上角
            // 问题文本及内容
            Column({ space: 12 }) {
              Text('小星列出了一些常见问题，不知道能否解决星崽的疑问？')
              // 遍历问题，只显示前三个
              ForEach(
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
              .backgroundColor('rgba(0, 0, 0, 0)')
              .onClick(() => {
                this.showAll = !this.showAll
              })
            }
          }.card()
        }
        // AI 问答部分
        ForEach(this.chatHistory, (message: ChatMessage) => {
          ListItem() {
            Column() {
              if (message.sender === 'user') {
                Row() {
                  Text(message.text)
                    .fontSize(16)
                    .backgroundColor(Color.White)  // 用户提问的背景颜色
                    .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                    .borderRadius(15)
                }
                .width('100%')
                .justifyContent(FlexAlign.End)
                .margin({ bottom: 10, left: 15, right: 15 });
              } else if (message.sender === 'ai') {
                Row() {
                  Text(message.text)
                    .fontSize(16)
                    .backgroundColor('#f4d4f4')  // AI 回答的背景颜色
                    .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                    .borderRadius(15)
                }
                .width('100%')
                .justifyContent(FlexAlign.Start)
                .margin({left: 15, right: 15 });
              }
            }.margin({top:10,left:20,right:20,bottom:10})
          }
        })


      }.height('62%')  // 给 List 设置一个高度，确保能够滚动显示内容
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
}
