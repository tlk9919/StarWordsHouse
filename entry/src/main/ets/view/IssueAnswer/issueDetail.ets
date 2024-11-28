import { detail } from '../../model/IssueAnswerdetail';
@Builder
export  function issueDetail(detail: detail | null) {
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
