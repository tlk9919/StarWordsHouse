@Extend(Checkbox) function CheckboxStyle() {
  .select(false) // 默认不选中
  .selectedColor('#fcb4e4') // 设置选中的背景色，填充整个复选框
  .unselectedColor('#D3D3D3') // 设置未选中时的边框颜色
  .shape(CheckBoxShape.CIRCLE) // 设置形状为圆形
  .mark({
    strokeWidth: 0 // 不显示√
  })
  .onChange((isSelected: boolean) => {});
}
// 用于生成复选框和内容
@Builder function CheckboxContent(ConditionName: string) {
  Row() {
    Checkbox({ name:ConditionName })//传入复选框名称，来动态创建复选框。
      .CheckboxStyle()//复选框样式
    Text(ConditionName)// 显示复选框名称
  }
}
@Component
export struct moodDiary2 {
  @Consume NowTime: Date
  build() {
    Column({ space: 10 }) {
      // 日期
      Row() {
        Text('日期：').fontSize(10)
        Text(this.NowTime.toLocaleDateString('zh-CN', {
          weekday: 'long',   // 显示星期几
          year: 'numeric',   // 显示年份
          month: 'long',     // 显示月份
          day: 'numeric'     // 显示日期
        })).fontSize(10)
      }
      // 胸部
      this.Section('胸部', ['一切正常', '肿胀', '硬块', '凹陷'])
      // 白带
      this.Section('白带', ['干燥', '粘稠', '乳液状', '渣渣多', '发绿', '带血色', '异味'])
      // 肠胃
      this.Section('肠胃', ['消化不良', '反胃', '屁多', '贪吃', '便秘', '腹泻'])
      // 身体
      this.Section('身体', [
        '头晕', '头痛', '潮热', '盆腔疼痛', '宫颈扩张', '私处见红', '瘙痒', '颈痛',
        '肩痛', '背痛', '腰痛', '四肢酸痛', '腹痛腹胀', '排卵疼痛'
      ])
    }
  }
  // 具体内容，通过foreach循环渲染显示
  @Builder Section(title: string, options: string[]) {
    Column({ space: 20 }) {
      // 标题和信息图标
      Row() {
        Stack() {
          Text(title).margin({ right: 70 })
          Image($r('app.media.record_mood_InfoBtn')).width('5%')
          Divider().color('#FFEB3B').strokeWidth('30px').width('10%').position({ x: 2, y: 10 }).opacity(0.5)
        }
      }
      .width('80%')
      Column({ space: 10 }) {
        // 复选框项
        Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
          ForEach(options, (option: string) => {
            CheckboxContent(option)  //展示具体状况
          })
        }
      }
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(15)
    .padding({ top: 20, bottom: 20 })
  }
}
