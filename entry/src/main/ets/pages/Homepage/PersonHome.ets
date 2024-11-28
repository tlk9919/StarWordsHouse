@Entry
@Component
struct PersonHome {
  @State Nickname :string='可乐麦旋风'
  @State ID :string='10000'
  @State MenstrualCycle : number=27
  @State MenstrualLength :number=7

  build() {
      Column() {
        //顶部个人中心
        Text('个人中心')
          .margin(20)
          .padding(8)
          .backgroundColor(Color.White)
          .borderRadius(10)
        //头像昵称等显示区域
        Row({space:10}){
          //头像
          Image($r('app.media.avatar')).width('25%')
          Column({space:20}){
            //昵称
            Text(this.Nickname).fontWeight(FontWeight.Bold).fontSize('60px')
            Row({space:5}){
              Text('ID:').fontColor('#636e72').fontSize('55px')
              Text(this.ID).fontColor('#636e72').fontSize('55px')
            }
          }
          Image($r('app.media.PersonHomeBack'))
            .width(25)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        //经期设置等具体信息
        Column({space:5}){
          Column(){
            Row(){
              Text('经期设置').margin(15)
            }.justifyContent(FlexAlign.Start).width('100%')
          }.margin({left:10})
          Row(){
            Text('例假周期：'+this.MenstrualCycle+'天').backgroundColor('#fcdcec').padding(10).borderRadius(10)
            Text('惊奇长度：'+this.MenstrualLength+'天').backgroundColor('#fcdcec').padding(10).borderRadius(10)
          }.justifyContent(FlexAlign.SpaceAround).width('100%')
          Column(){
            //
            Row(){
              Row(){
                Image($r('app.media.homeset')).width('200px')
                Text('使用设置')
              }.margin({left:10})
              Row(){ Image($r('app.media.PersonHomeBack')).width('60px')}.margin({right:30})
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)
            //
            Row(){
              Row(){
                Image($r('app.media.Homenotify')).width('200px')
                Text('例假通知')
              }.margin({left:10})
              Row(){ Image($r('app.media.PersonHomeBack')).width('60px')}.margin({right:30})
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)
            //客服与投诉
            Row(){
              Row(){
                Image($r('app.media.Homecomplaint')).width('140px')
                Text('客服与投诉').margin({left:10})
              }.margin({left:20})
              Row(){ Image($r('app.media.PersonHomeBack')).width('60px')}.margin({right:30})
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)
          }.width('100%').margin({top:50})
        }
        .margin({top:30})
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)
        .borderRadius(30)

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#ecc4f4')
    .borderRadius({topLeft:15,topRight:15})

  }
}