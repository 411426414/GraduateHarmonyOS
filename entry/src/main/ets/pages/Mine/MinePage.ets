import router from '@ohos.router';
import { userIndex } from '../../Api/user';
import { UserInfoModel } from '../../viewmodel/UserModel';

const flagTag: string = '我的'

@Entry
@Component
export default struct MinePage {
  @State UserInfo: UserInfoModel = {}

  aboutToAppear() {
    console.log(`${flagTag} aboutToAppear`)
  }

  onPageShow() {
    this.getUserInfo()
  }

  getUserInfo() {
    userIndex().then(res => this.UserInfo = res.data.userInfo)
  }

  build() {
    Column() {
      this.userBaseInfoBox(this.UserInfo)
      this.menuListBox()
    }.width('100%').height('100%').backgroundColor('#f1f1f1')
  }

  @Builder
  userBaseInfoBox(UserInfo: UserInfoModel) {
    Row() {
      Row() {
        Image($r('app.media.img')).width(75).height(75).objectFit(ImageFit.Contain).borderRadius(50)
        Column() {
          if (this.UserInfo.nickname && this.UserInfo.mobile) {
            Text(this.UserInfo.nickname).fontSize(22).fontWeight(FontWeight.Bold)
            Text(this.UserInfo.mobile).fontSize(16).margin({ top: 10 }).fontColor(0x8a8a8a)
          } else {
            Text('请登录').fontSize(22).fontWeight(FontWeight.Bold)
          }
        }
        .margin({ left: 10 })
        .backgroundImageSize(ImageSize.Auto)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      }

      Image($r('app.media.icon_setting')).width(25)
    }
    .width('95%')
    .margin(10)
    .padding(10)
    .borderRadius(15)
    .backgroundColor('#FFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      if (!AppStorage.Get('token')) {
        router.replaceUrl({ url: 'pages/Mine/LoginPage' })
      } else {
        this.getUserInfo()
      }
    })
  }

  @Builder
  menuListBox() {
    Column() {
      this.menuItem('设置', $r('app.media.left_arrow'), 'pages/Mine/settingPage')
      this.menuItem('我的收藏', $r('app.media.left_arrow'), 'pages/Wallpaper/WallpaperPage')
      this.menuItem('我的下载', $r('app.media.left_arrow'), 'pages/Wallpaper/WallpaperPage')
      this.menuItem('我的订单', $r('app.media.left_arrow'), 'pages/Tram/TramPage')
      this.menuItem('列表页面', $r('app.media.left_arrow'), 'pages/ActivePage')
      this.menuItem('传感器页面', $r('app.media.left_arrow'), 'pages/Sensor/SensorListPage')
    }
    .width('95%')
    .backgroundColor('#FFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin(10)
    .padding(10)
    .borderRadius(15)
  }

  @Builder
  menuItem(title: string, icon: Resource, url?: string) {
    Row() {
      Row() {
        Image($r('app.media.ic_privacy')).width(20)
        Text(title).margin({ left: 10 })
      }

      Image(icon).width(20)
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .onClick(() => router.pushUrl({ url }))
  }
}