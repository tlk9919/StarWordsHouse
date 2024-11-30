@CustomDialog
@Preview
export struct DetailDialog {
  @Provide Nickname: string = '可乐麦旋风'
  @State Age: number = 20
  @State selectedGender: string = '' // 存储选中的性别
  controller: CustomDialogController
  // 提取通用的 Row 布局
  @Builder
  buildRow(label: string, value: string | number, isRadio: boolean = false, marginBottom: number = 0) {
    Row() {
      Text(label).width('30%').margin({ left: 20 })
      if (isRadio) {
        // 性别选择框
        Row({ space: 5 }) {
          // 手动创建每个性别选项
          Radio({ value: '男', group: 'radioGroup' })
            .checked(this.selectedGender === '男')
            .radioStyle({
              checkedBackgroundColor: '#FF69B4',
              uncheckedBorderColor: '#D3D3D3',
              indicatorColor: '#FF69B4'
            })
            .onChange((isChecked) => {
              if (isChecked) {
                this.selectedGender = '男';
              }
            })
          Text('男')
          Radio({ value: '女', group: 'radioGroup' })
            .checked(this.selectedGender === '女')
            .radioStyle({
              checkedBackgroundColor: '#FF69B4',
              uncheckedBorderColor: '#D3D3D3',
              indicatorColor: '#FF69B4'
            })
            .onChange((isChecked) => {
              if (isChecked) {
                this.selectedGender = '女';
              }
            })
          Text('女')
        }
        .width('60%')
        .margin({ left: 30 })
        .justifyContent(FlexAlign.Start)
      } else {
        // 普通文本显示
        Text(`${value}`).margin({ right: 20 })
      }
    }
    .width('90%')
    .height(65)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
    .borderRadius(15)
    .padding(15)
    .margin({ bottom: marginBottom }) // 设置底部间距
  }
  build() {
    Column({ space: 20 }) {
      // 个人信息标题
      Text('个人信息').margin(15).fontSize(20).fontWeight('bold')

      // 头像容器
      Row() {
        Text('头像').width('30%').margin({ left: 20 })
        Image($r('app.media.avatar')).width('150px').margin({ right: 20 })
      }
      .width('90%')
      .height(65)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Color.White)
      .borderRadius(15)
      .padding(10)
      this.buildRow('昵称', this.Nickname)
      this.buildRow('年龄', this.Age)
      this.buildRow('性别', '', true, 20) // 设置性别容器底部间距为 20
    }
    .width('100%')
    .backgroundColor('#fcdcec')
  }
}
