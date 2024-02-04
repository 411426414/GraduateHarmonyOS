@Component
export default struct Input {
  title: string
  placeholder: string
  @Link defaultValue: string
  inputType: InputType = InputType.Normal
  icon: Resource
  @State isFocus: boolean = false
  change = (val: string) => {
  }

  build() {
    Column() {
      Text(this.title)
        .width('100%')
        .textAlign(TextAlign.Start)
        .fontSize(16)
        .fontWeight(500)
        .fontColor('#001648')
        .margin({ bottom: 14 })
      Flex({ alignItems: ItemAlign.Center }) {
        Image(this.icon).width(30).height(30)
        TextInput({ text: this.defaultValue, placeholder: this.placeholder })
          .placeholderColor('rgba(0,40,132,0,6')
          .backgroundColor(Color.White)
          .style(TextInputStyle.Inline)
          .width('100%')
          .type(this.inputType)
          .onFocus(() => {
            this.isFocus = true
          })
          .onBlur(() => {
            this.isFocus = false
          })
          .onChange((val: string) => {
            this.change(val)
          })

      }
      .height(50)
      .width('100%')
      .padding({ left: 10, right: 10 })
      .borderRadius(10)
      .border({
        width: this.isFocus ? 2 : 0,
        color: '#002884'
      })

      if (this.isFocus && this.inputType === InputType.Password) {
        if (this.defaultValue.length < 8)
          Text('密码长度至少8个字符;').fontSize(12).fontColor('#999')
        if (!/[A-Z]/.test(this.defaultValue))
          Text('至少包含1个大写字母;').fontSize(12).fontColor('#999')
        if (!/[a-z]/.test(this.defaultValue))
          Text('至少包含1个小写字母').fontSize(12).fontColor('#999')
        if (!/[0-9]/.test(this.defaultValue))
          Text('至少包含1个数字;').fontSize(12).fontColor('#999')
      }
    }
  }

  /**
   * var str1 = "Hello World";
   * console.log(hasUpperCase(str1)); // true
   * var str2 = "hello world";
   * console.log(hasUpperCase(str2)); // false
   * */
  hasUpperCase(str) {
    var regex = /[A-Z]/; // 定义正则表达式，匹配任意大写字母
    return regex.test(str); // 返回true或false，表示字符串中是否有大写字母
  }
}