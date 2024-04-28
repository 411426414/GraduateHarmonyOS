import { Banner, ClassInfo, Notice } from '../viewmodel/BannerModel';
import { BannerList, ClassInfoList, NoticeList } from '../Api/homePage';
import router from '@ohos.router';

const flagTag: string = '首页'

@Entry
@Component
export default struct HomePage {
  @State swiperList: Array<Banner> = [
  //   { "coverimage": "/uploads/20230318/5060835d87b8a2383f1eb7e1ec8b2743.png", }
  ]
  @State noticeList: Array<Notice> = [
  //   { "title": "公告标题", }
  ]
  @State classInfoList: Array<ClassInfo> = []
  @State isLoading: boolean = false

  aboutToAppear() {
    console.log(`${flagTag} aboutToAppear`)
    this.getBannerList()
    this.getNoticeList()
    this.getClassInfoList()
  }

  onPageShow() {
    console.log(`${flagTag} onPageShow`)
    this.isLoading = true
  }

  getBannerList() {
    BannerList()
      .then(res => {
        // console.info(`${flagTag} getBannerList success`, JSON.stringify(res.data.data))
        this.swiperList = res.data
      })
      .catch(err => {
        console.info(`${flagTag} getBannerList fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  getNoticeList() {
    NoticeList()
      .then(res => {
        // console.info(`${flagTag} getBannerList success`, JSON.stringify(res.data.data))
        this.noticeList = res.data
      })
      .catch(err => {
        console.info(`${flagTag} getBannerList fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  getClassInfoList() {
    ClassInfoList()
      .then(res => {
        this.classInfoList = res.data
      })
      .catch(err => {
        console.info(`${flagTag} ClassInfoList fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  build() {
    Column({ space: 8 }) {
      if (this.isLoading) {
        LoadingProgress()
          .color('#0091ff')
          .width(50)
      }
      Scroll() {
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center,
          alignItems: ItemAlign.Center
        }) {
          if (this.swiperList.length > 0)
            BannerBox({ swiperList: $swiperList })
          if (this.noticeList.length > 0)
            NoticeBox({ noticeList: $noticeList })
          ClassInfoBox({ classInfoList: $classInfoList })
          Button('传感器页面')
            .width('50%')
            .margin({ top: 50 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/Sensor/SensorListPage' })
            })
        }
      }
      .margin('12vp')
    }
    .height('100%')
    .backgroundColor('#F2F3F5')
  }
}

@Component
struct BannerBox {
  @Link swiperList: Banner[]

  build() {
    // 轮播图
    Swiper() {
      ForEach(this.swiperList, (item: Banner) => {
        Stack({ alignContent: Alignment.TopStart }) {
          Image('https://gzh.411426414.top' + item.coverimage)
            .borderRadius('16vp')
          // .objectFit(ImageFit.Contain)

          Column() {
            Text('电影精选')
              .textStyle(12, 400)
              .opacity(0.9)
              .margin({ bottom: 4 })
            Text(item.title).textStyle(20, 700)
          }
          .alignItems(HorizontalAlign.Start)
          .height(90)
          .margin({ top: 12, left: 12 })
        }
        .height('100%')
        .width('100%')
      }, (item: Banner) => JSON.stringify(item))
    }
    .height(200)
    .width('100%')
    .margin({ bottom: 5 })
    .duration(1000)
    .loop(true)
    .autoPlay(true)
  }
}

@Component
struct NoticeBox {
  @Link noticeList: Notice[]

  build() {
    Row() {
      Text('公告：')
      // 轮播图
      Swiper() {
        ForEach(this.noticeList, (item: Notice) => {
          Text(item.title)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/Notice/NoticePage'
              })
            })
        }, (item: Notice) => JSON.stringify(item))
      }
      .width('100%')
      .loop(true)
      .duration(1000)
      .autoPlay(true)
      .indicator(false)
      .vertical(true)
    }
    .alignItems(VerticalAlign.Center)
    .height(25)
    .padding({ left: 10, right: 10 })
    .borderRadius(24)
  }
}

@Component
struct ClassInfoBox {
  @Link classInfoList: ClassInfo[]

  build() {
    // 分类信息
    List() {
      ForEach(this.classInfoList, (item: ClassInfo, index: number) => {
        ListItem() {
          Column() {
            Image($r('app.media.img'))
              .width(50)
              .height(50)
              .borderRadius(25)
              .margin({ left: 10, right: 10, top: 10, bottom: 10 })
            Text(item.name)
          }
          .onClick(() => {
            console.log('item', JSON.stringify(item))
            // router.pushUrl({ url: 'pages/ZixunPage', params: { currentIndex: index } })
          })
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .edgeEffect(EdgeEffect.None)
    .width('100%')
    .onClick(_ => {
      console.info("this.classInfoList", JSON.stringify(this.classInfoList))
    })
  }
}

/**
 * @param fontSize 字体大小
 * @param fontWeight 字体粗细
 */
@Extend(Text)
function textStyle(fontSize: number, fontWeight: number) {
  .fontSize(fontSize)
  .fontColor($r('app.color.start_window_background'))
  .fontWeight(fontWeight)
}