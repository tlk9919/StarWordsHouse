import { ChatMessage } from '../../model/getAnswer'
import getAnswerService from '../../Service/getAnswerService';

@Entry
@Component
export struct submitIssue {
  @State issueText: string = '';
  @State chatHistory: ChatMessage[] = [];
  build() {
    List(){
      ListItem(){
        Column() {
          // 显示对话
          ForEach(this.chatHistory, (message: ChatMessage) => {
            if (message.sender === 'user') {
              Row() {
                // 用户提问样式
                Text(message.text)
                  .fontSize(16)
                  .fontColor('#ffffff')
                  .backgroundColor('#4c94ec')  // 用户提问的气泡颜色
                  .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                  .borderRadius(15)
                  .margin({ bottom: 10, left: 15 });
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
            } else if (message.sender === 'ai') {
              Row() {
                // AI 回答样式
                Text(message.text)
                  .fontSize(16)
                  .fontColor('#ffffff')
                  .backgroundColor('#2e8b57')  // AI 回答的气泡颜色
                  .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                  .borderRadius(15)

                  .margin({ bottom: 10, right: 15 });
              }
              .width('100%').justifyContent(FlexAlign.End)
            }
          });

          Row() {
            // 输入框
            TextInput({ placeholder: '向我提问吧' })
              .width('80%')
              .height(50)
              .margin({ bottom: 15 })
              .caretColor('#b44444')
              .borderWidth(2)
              .borderColor('#a43c58')
              .onChange((text: string) => {
                this.issueText = text;
              });

            // 提交按钮
            Button() {
              Image($r('app.media.send'))
                .width(50)
                .height(50)
                .borderRadius(25)
                .backgroundColor('#e48494')
                .padding(8);
            }
            .onClick(async () => {
              if (this.issueText.trim() === '') {
                // 如果输入为空，显示提示框
                AlertDialog.show({
                  title: '温馨提示',
                  message: '请输入问题哦',
                  autoCancel: true
                });
                return;  // 终止后续操作
              }

              // 用户提交了问题
              this.chatHistory.push({ sender: 'user', text: this.issueText });
              this.issueText = '';  // 清空输入框

              // 调用封装的服务获取AI答案
              try {
                const answer: string = await getAnswerService.getAnswer(this.issueText);
                this.chatHistory.push({ sender: 'ai', text: answer });  // 显示AI的回答
              } catch (error) {
                console.error('获取答案失败:', error);
                this.chatHistory.push({ sender: 'ai', text: '抱歉，无法回答这个问题哦。' });
              }
            });
          }
        }.width('100%')
      }
    }

  }
}