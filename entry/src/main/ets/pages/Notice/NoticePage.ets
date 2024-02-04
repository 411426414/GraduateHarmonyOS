import { NoticeList } from '../../Api/homePage'
import { Notice } from '../../viewmodel/BannerModel'

const flagTag: string = '公告'

@Entry
@Component
struct NoticePage {
  @State message: string = 'Hello World'
  @State noticeList: Array<Notice> = []
  @State isLoading: boolean = false
  scroller = new Scroller()

  onPageShow() {
    this.getNoticeList()
  }

  getNoticeList() {
    this.isLoading = true
    NoticeList()
      .then(res => {
        console.info(`${flagTag} getBannerList success`, JSON.stringify(res.data))
        this.noticeList = res.data
      })
      .catch(err => {
        console.info(`${flagTag} getBannerList fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        // Text(this.message)
        if (this.isLoading) {
          LoadingProgress()
            .color(Color.Blue)
            .width(75)
        } else {
          Column() {
            ForEach(this.noticeList, (item, index) => {
              Column() {
                Text(item.title)
                  .maxLines(2)
                  .fontColor(Color.Black)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Row() {
                  Text(`发布人：${item.publiserby}`).fontColor(Color.Black).fontSize(12)
                  Text(`发布时间：${item.publishdate}`).fontColor(Color.Black).fontSize(12)
                }
                .width('100%')
                .margin({ top: 10 })
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .width('95%')
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#CCC')
              .padding(10)
              .margin({ bottom: 5 })
              .borderRadius(10)
            })
          }
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
}