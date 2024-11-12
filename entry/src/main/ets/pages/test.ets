@Entry
@Component
struct LoginRegisterPage {
  @State currentTab: string = 'login'; // 初始显示登录卡片

  build() {
    Column() {



      // 标题
      Text('Login/Register').fontSize(24).padding(10)

      // 登录/注册文本切换
      Row({ space: 10 }) {
        // 登录文本
        Text('Login')
          .fontSize(18)
          .fontColor(this.currentTab === 'login' ? '#007BFF' : '#000000') // 当前选中的文本变蓝，未选中的为黑色
          .onClick(() => {
            this.currentTab = 'login'; // 设置为登录卡片
          })
          .padding(10)

        // 注册文本
        Text('Register')
          .fontSize(18)
          .fontColor(this.currentTab === 'register' ? '#007BFF' : '#000000') // 当前选中的文本变蓝，未选中的为黑色
          .onClick(() => {
            this.currentTab = 'register'; // 设置为注册卡片
          })
          .padding(10)
      }
      // 登录卡片内容
      if (this.currentTab === 'login') {
        Column({ space: 10 }) {
          Text('Login').fontSize(20)
          TextInput({ placeholder: 'Username' }).padding(10)
          TextInput({ placeholder: 'Password' }).padding(10)
          Button('Login')
            .onClick(() => {
              // 登录逻辑
              console.log('Login clicked')
            })
            .padding(10)
        }
        .padding(20); // 为整个 Column 添加 padding
      }

      // 注册卡片内容
      if (this.currentTab === 'register') {
        Column({ space: 10 }) {
          Text('Register').fontSize(20)
          TextInput({ placeholder: 'Username' }).padding(10)
          TextInput({ placeholder: 'Password' }).padding(10)
          TextInput({ placeholder: 'Confirm Password' }).padding(10)
          Button('Register')
            .onClick(() => {
              // 注册逻辑
              console.log('Register clicked')
            })
            .padding(10)
        }
        .padding(20); // 为整个 Column 添加 padding
      }
    }
    .width('100%')
    .height('100%')
    .padding(20); // 给整个布局添加 padding
  }
}
