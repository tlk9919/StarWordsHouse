import { ChatMessage } from "../../model/getAnswer";
import getAnswerService from "../../Service/getAnswerService"; // 确保引入的是 GetAnswerService 类

@Component
export struct submitIssue {
  @Link issueText: string
  @Link chatHistory: ChatMessage[]

  build() {
    Column() {
      List() {
        ListItem() {
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
              const currentIssue = this.issueText;  // 保存当前问题
              this.issueText = '';  // 清空输入框

              // 调用封装的服务获取AI答案
              try {
                const answer: string = await getAnswerService.getAnswer(currentIssue);
                this.chatHistory.push({ sender: 'ai', text: answer });  // 显示AI的回答
                console.log('AI 回答:', answer);  // 输出 AI 回答
              } catch (error) {
                console.error('获取答案失败:', error);
                this.chatHistory.push({ sender: 'ai', text: '抱歉， 无法回答这个问题。' });
              }
            });
          }
        }
      }
    }
  }
}
