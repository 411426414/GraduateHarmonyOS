import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import TitleComponent from '../../components/TitleComponent';
import Input from '../../components/Input';
import { userLogin } from '../../Api/user';
import { UserInfoModel } from '../../viewmodel/UserModel';


@Entry
@Component
struct LoginPage {
  num: number = 60
  @State isRegister: boolean = false
  @State countDown: number = 60
  timer: number
  @State account: string = 'zhengjie'
  @State password: string = '123456'
  @State verifyCode: string = ''
  @State userinfo: UserInfoModel = {}
  @State isDisable: boolean = false
  chang = (val: string) => {
  }

  // 发送验证码
  sendCode() {
    this.startSendCode()
  }

  doLogin() {
    if (this.account == '' || this.password == '') {
      promptAction.showToast({
        message: '账号或密码不能为空',
        duration: 3000,
      })
      return
    }
    console.log('登录');
    userLogin({ account: this.account, password: this.password })
      .then(res => {
        this.userinfo = res.data.userinfo
        let token = this.userinfo.token
        AppStorage.SetOrCreate('token', token)
        setTimeout(() => router.replaceUrl({ url: 'pages/Mine/MinePage' }), 2000)
      })
      .catch(err => {
        console.log('err: ', JSON.stringify(err))
        promptAction.showToast({
          message: '账号或密码错误',
          duration: 3000
        })
      })
      .finally(() => {
        this.isDisable = false
      })
  }

  // 开始倒计时
  startSendCode() {
    this.timer = setInterval(() => {
      this.countDown--
      if (this.countDown === 0) {
        this.countDown = 60
        clearInterval(this.timer)
      }
    }, 1000)
  }

  register() {
    // 通过code + 密码 + 邮箱 登录
    console.log('register')
    this.isRegister = false
  }

  build() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, }) {
      // 标题
      TitleComponent({ title: '登录' })

      // 登录表单
      Column() {
        Stack() {
          Image($r('app.media.img'))
            .width(88)
            .height(88)
            .offset({ y: -44 })
        }

        Input({
          title: '电子邮箱',
          icon: $r('app.media.img'),
          placeholder: '请输入您的用户名',
          defaultValue: $account,
          change: (val) => {
            this.account = val
          }
        })

        Input({
          title: '密码',
          icon: $r('app.media.img'),
          placeholder: '请输入您的密码',
          inputType: InputType.Password,
          defaultValue: $password,
          change: (val) => {
            this.password = val
          }
        }).margin({ top: 20 })

        if (false) { //this.isRegister
          Column() {
            Text('验证码')
              .width('100%')
              .textAlign(TextAlign.Start)
              .fontSize(16)
              .fontWeight(500)
              .fontColor('#001648')
              .margin({ bottom: 14 })
            Flex({
              alignItems: ItemAlign.Center,
            }) {
              TextInput()
                .height(50)
                .margin({ right: 10 })// .backgroundColor('#FBFBFD')
                .backgroundColor('#EEE')
                .onChange((val: string) => {
                  this.verifyCode = val
                })

              Button(this.countDown == 60 ? '获取验证码' : `${this.countDown}`)
                .fontSize(14)
                .width(this.countDown == 60 ? 175 : 60)
                .onClick(() => {
                  if (this.countDown === 60) {
                    this.sendCode()
                  }
                })
            }
          }
          .margin({ top: 20 })
        }

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Text(this.isRegister ? '注册' : '登录')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(17)
        }
        .width(228)
        .height(50)
        .backgroundColor('#38BFDA')
        .borderRadius(50)
        .margin({ top: 100 })
        .onClick(() => {
          console.log('this.isRegister', JSON.stringify(this.isRegister))
          if (!this.isDisable) {
            this.isDisable = true
            this.isRegister ? this.register() : this.doLogin()
          }
        })

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Text(this.isRegister ? '去登录' : '去注册')
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .fontSize(17)
            .onClick(() => {
              this.isRegister = !this.isRegister
            })
        }
        .width(228)
        .height(50)
        .backgroundColor('#F3F9FF')
        .borderRadius(50)
        .margin({ top: 20 })
      }
      .width('90%')
      .height('100%')
      .borderRadius(44)
      .margin({ top: 44 })
      .padding({ left: 14, right: 14 })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F3F9FF')
  }
}