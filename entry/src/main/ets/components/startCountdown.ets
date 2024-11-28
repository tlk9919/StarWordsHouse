
 class StartCountdown{
    seconds = 60; // 倒计时初始值

  // 获取验证码按钮点击事件
  startCountdown() {
    if (this.seconds === 0) {
      this.seconds = 60; // 设置倒计时为60秒

      // 开始倒计时
      const timerInterval = setInterval(() => {
        this.seconds -= 1;

        // 清除定时器并恢复按钮
        if (this.seconds <= 0) {
          clearInterval(timerInterval);
          this.seconds = 0; // 重置倒计时
        }
      }, 1000);
    }
  }
   // 获取倒计时秒数
   getSeconds() {
     return this.seconds;
   }

}
const startCountdown=new StartCountdown()
 export default startCountdown