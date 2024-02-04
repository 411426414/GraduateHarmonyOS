import { editUserInfo, userIndex, userInfo } from '../../Api/user'
import { TimestampToDate } from '../../utils/utils'
import { UserInfoModel } from '../../viewmodel/UserModel'
import promptAction from '@ohos.promptAction';

const flagTag: string = '设置'

@Entry
@Component
struct SettingPage {
  @State isShow: boolean = true
  @State textValue: string = ''
  @State UserInfo: UserInfoModel = {}
  scroller: Scroller = new Scroller();
  @State inputValue: string = 'click me'
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: this.onCancel,
      confirm: this.onAccept,
      UserInfo: $UserInfo,
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  aboutToAppear() {
    this.getUserInfo()
  }

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = undefined // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept(UserInfo, controller) {
    editUserInfo(UserInfo)
      .then(res => {
        console.info("res", JSON.stringify(res))
        this.UserInfo = UserInfo
        controller.close()
        this.getUserInfo()
      })
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }

  getUserInfo() {
    userIndex()
      .then(res => {
        this.UserInfo = res.data.userInfo
        this.UserInfo.prevTime = TimestampToDate(this.UserInfo.prevtime)
        this.UserInfo.loginTime = TimestampToDate(this.UserInfo.logintime)
        this.UserInfo.joinTime = TimestampToDate(this.UserInfo.jointime)
        this.UserInfo.createTime = TimestampToDate(this.UserInfo.createtime)
        this.isShow = false
      })
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        if (this.isShow) {
          LoadingProgress()
            .color(Color.Blue)
            .width(75)
        } else {
          Column() {
            this.UserInfoItemBox()

            Row() {
              Button('修改信息').width('50%').onClick(() => {
                if (this.dialogController != undefined) {
                  this.dialogController.open()
                }
              })
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            // .position({ y: 650 })
            .width('100%')
            .padding({ top: 25 })
          }
          .width('95%')
          .padding(10)
          .backgroundColor('#FFF')
          .borderRadius(15)
          .padding({ bottom: 15 })
        }
      }
      .width('100%')
      .padding({ top: 10 })
      .backgroundColor('#f1f1f1')
    }
    .backgroundColor(0xDCDCDC)
    .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
    .scrollBar(BarState.Auto) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    // .scrollBarWidth(10) // 滚动条宽度
    .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
  }

  @Builder UserInfoItemBox() {
    UserInfoItem({ label: '编号', value: `${this.UserInfo.user_id}` })
    UserInfoItem({ label: '用户昵称', value: this.UserInfo.nickname })
    UserInfoItem({ label: '用户名称', value: this.UserInfo.username })
    UserInfoItem({ label: '联系方式', value: this.UserInfo.mobile })
    UserInfoItem({ label: '电子邮箱', value: this.UserInfo.email })
    UserInfoItem({ label: '性别', value: this.UserInfo.gender == 1 ? '男' : '女' })
    UserInfoItem({ label: '积分', value: `${this.UserInfo.score}` })
    UserInfoItem({ label: '生日', value: this.UserInfo.birthday })
    UserInfoItem({ label: '格言', value: this.UserInfo.bio })
    UserInfoItem({ label: '下载次数', value: `${this.UserInfo.download_num}` })
    UserInfoItem({ label: '上次登录时间', value: this.UserInfo.prevTime })
    UserInfoItem({ label: '登录时间', value: this.UserInfo.loginTime })
    UserInfoItem({ label: '登录IP', value: this.UserInfo.loginip })
    UserInfoItem({ label: '失败次数', value: `${this.UserInfo.loginfailure}` })
    UserInfoItem({ label: '加入IP', value: this.UserInfo.joinip })
    UserInfoItem({ label: '加入时间', value: this.UserInfo.joinTime })
    UserInfoItem({ label: '创建时间', value: this.UserInfo.createTime })
  }
}

@Component
struct UserInfoItem {
  label: string
  value: string

  build() {
    Column() {
      Row() {
        Text(this.label).fontColor(0x000000)
        Text(this.value).fontColor(0x000000)
      }
      .width('100%')
      .margin({ left: 10, right: 10 })
      .padding(15)
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}


@CustomDialog
struct CustomDialogExample {
  @Link UserInfo: UserInfoModel
  controller: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，
  // 以实现在CustomDialog中打开另一个或另一些CustomDialog，
  // 那么此处需要将指向自己的controller放在最后
  cancel: () => void
  confirm: (UserInfo, controller) => void
  private gender: string[] = ['女', '男']

  build() {
    Column() {
      Column() {
        // 头像
        Row() {
          Text('用户昵称')
          TextInput({ placeholder: '', text: this.UserInfo.nickname })
            .width('75%')
            .onChange((value: string) => this.UserInfo.nickname = value)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 5, bottom: 5 })

        Row() {
          Text('用户名称')
          TextInput({ placeholder: '', text: this.UserInfo.username })
            .width('75%')
            .onChange((value: string) => this.UserInfo.username = value)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 5, bottom: 5 })

        Row() {
          Text('联系方式')
          TextInput({ placeholder: '', text: this.UserInfo.mobile })
            .width('75%')
            .onChange((value: string) => this.UserInfo.mobile = value)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 5, bottom: 5 })

        Row() {
          Text('电子邮箱')
          TextInput({ placeholder: '', text: this.UserInfo.email })
            .width('75%')
            .onChange((value: string) => this.UserInfo.email = value)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 5, bottom: 5 })

        Row() {
          Text('性        别')
          TextInput({ placeholder: '', text: this.UserInfo.gender == 1 ? '男' : '女' })
            .width('75%')
            .onClick(() => {
              TextPickerDialog.show({
                range: this.gender,
                selected: this.UserInfo.gender,
                onAccept: (value: TextPickerResult) => {
                  this.UserInfo.gender = value.index
                }
              })
            })
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 5, bottom: 5 })

        Row() {
          Text('生        日')
          TextInput({ placeholder: '', text: this.UserInfo.birthday })
            .width('75%')
            .onClick(() => {
              DatePickerDialog.show({
                selected: new Date(this.UserInfo.birthday),
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  // new Date(this.UserInfo.birthday).setFullYear(value.year, value.month, value.day)
                  this.UserInfo.birthday = `${value.year}-${value.month + 1}-${value.day}`
                },
              })
            })
        }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: 5, bottom: 5 })
      }

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            promptAction.showDialog({
              message: '是否保存修改？',
              buttons: [
                { text: '取消', color: '#666' },
                { text: '确定', color: '#00F' }
              ]
            })
              .then(data => {
                if (data.index === 1) {
                  this.confirm(this.UserInfo, this.controller)
                }
              })
          }).backgroundColor(0xffffff).fontColor(Color.Blue)
      }.margin({ bottom: 10 })
    }
    .padding({ top: 20, bottom: 20, left: 20, right: 20 })
    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
  }
}