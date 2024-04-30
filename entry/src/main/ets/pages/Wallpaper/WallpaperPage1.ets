import router from '@ohos.router'
import { WaterFlowDataSource } from '../../utils/WaterFlowDataSource'
import { PyImg1, PyImgData1 } from '../../viewmodel/PyImg'

const flagTag: string = '壁纸'

@Entry
@Component
struct WallpaperPage {
  @State PyImg: PyImg1[] = []
  @State minSize: number = 50
  @State maxSize: number = 100
  @State fontSize: number = 24
  @State colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]
  scroller: Scroller = new Scroller()
  private datasource
  private itemHeightArray: number[] = []

  aboutToAppear() {
    // getPyImg().then(res => {
    //   this.PyImg = res.data
    // })
    PyImgData1.map((item: PyImg1) => {
      item.height = item.height ?? 0
      item.width = item.width ?? 0
    })
    this.PyImg = PyImgData1

    this.getItemSizeArray(this.PyImg)
  }

  // 保存flow item宽/高
  getItemSizeArray(data) {
    let _this = this
    data.forEach((item: PyImg1) => {
      if (item.width && item.height) {
        _this.itemHeightArray.push(Number(item.height) / (Number(item.width) / 169))
      }
    })
    this.datasource = new WaterFlowDataSource(this.PyImg)
  }

  build() {
    Column({ space: 6 }) {
      // footer: this.itemFoot.bind(this),
      WaterFlow({ scroller: this.scroller }) {
        LazyForEach(this.datasource, (item: PyImg1, index: number) => {
          FlowItem() {
            Column() {
              Image(item.url)
                .width('100%')
                .height(this.itemHeightArray[index])
                .objectFit(ImageFit.Contain)
                .borderRadius({ topLeft: 15, topRight: 15 })
              Column() {
                Text(item.pic_alt)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                Text(`创建时间：${item.createtime}`)
                  .fontSize(12)
                  .height('16')
                  .margin({ top: 5, bottom: 5 })
                  .fontColor('#AAA')
                  .fontWeight(FontWeight.Bold)
              }
              .margin(5)
              .alignItems(HorizontalAlign.Start)
            }
            .borderRadius(15)
            // .backgroundColor(this.colors[index % 5])
            .backgroundColor('#EEE')
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Wallpaper/WallpaperDetailPage',
              params: {
                wallpaper_id: item.id,
              }
            })
          })
        }, item => JSON.stringify(item))
      }
      .columnsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(5)
      // .backgroundColor(0xFAEEE0)
      .width('100%')
      .height('100%')
      .layoutDirection(FlexDirection.Column)
      .itemConstraintSize({
        minWidth: 0,
        maxWidth: '100%',
        minHeight: 0,
        maxHeight: '100%'
      })
      .onReachStart(() => {
        console.info("onReachStart")
      })
      .onReachEnd(() => {
        console.info("onReachEnd")
      })
    }
    .margin({ left: 6, right: 6 })
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  itemFoot() {
    Column() {
      Text(`Footer`)
        .fontSize(10)
        .backgroundColor(Color.Red)
        .width(50)
        .height(50)
        .align(Alignment.Center)
        .margin({ top: 2 })
    }
  }
}