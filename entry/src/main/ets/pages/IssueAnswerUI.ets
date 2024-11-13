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
  .position({left:65,top:200})
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

//问答界面样式
@Entry
@Component
struct issueAnswerUI {
  //标记变量
  @State selectedIndex: number = -1  // 表示没有选中的问题
  //标记字体颜色
  @State color: string = '#4c94ec'

  private words: Array<detail> = [
    new detail('怎么改善月经不调', $r("app.media.detailClick")),
    new detail('怎样区分原发性痛经和继发性痛经', $r("app.media.detailClick")),
    new detail('经期推迟', $r("app.media.detailClick")),
    new detail('怎样缓解经期痛', $r("app.media.detailClick")),
    new detail('经期提前', $r("app.media.detailClick")),
    new detail('女生第一次来例假时间', $r("app.media.detailClick")),
    new detail('月经回朝', $r("app.media.detailClick"))
  ]

  build() {
    Column() {
      //返回图标
      Header()
      //云
      Image($r('app.media.cloud'))
        .height(160)
      //兔子
      Image($r('app.media.rabbit'))
        .height('160')
        .position({ x: 15, y: 470 })
      // 使用 Stack 叠放图片和文字内容
      Row() {
        // 头像图片
        Image($r('app.media.avatar'))
          .width(60)
          .height(60)
          .position({ x: 0, y: 170 })  // 定位到左上角

        // 问题文本及内容
        Column({ space: 12 }) {
          Text('小星列出了一些常见问题，不知道能否解决星崽的疑问？')
          //遍历问题
          ForEach(
            //数组
            this.words,
            (item: detail, index: number) => {
              Row() {
                Text(item.title)
                  .fontSize(18)
                  .fontColor(this.selectedIndex === index ? '#949494' : this.color)
                  .onClick(() => {
                    this.selectedIndex = index
                  })
                Blank()
                Button() {
                  Image(item.clickImage)
                    .width(20)
                    .backgroundColor(Color.White)
                }
                //点击事件
                .onClick(() => {
                  this.selectedIndex = index
                })
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
            }
          )

        }.card()
      }

      //问答输入框
      Blank()
      Stack() {
        TextInput({ placeholder: '向我提问吧' })
          .width('80%')
          .height(50)
          .margin({ bottom: 15 })
          .caretColor('#b44444') //光标颜色
          .borderWidth(2)
          .borderColor('#a43c58')
          .position({ x: -30 })
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
        .position({ x: 270, y: 0 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fccccc')
  }
}
