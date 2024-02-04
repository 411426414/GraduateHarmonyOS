const flagTag: string = '活动'

class Active {
  image: string
  title: string
  date: string
  id: number
  address: string
  status: string
  has_sign_up: number
  sign_up_count: number
}

@Entry
@Component
struct ActivePage {
  @State message: string = 'Hello World'
  @State isLoading: boolean = false
  @State ListOrCard: boolean = false
  scroller = new Scroller()
  @State activeList: Active = {
    image: 'https://gzh.411426414.top/uploads/20240203/767176491ecce32feb37f053cf69ed14.jpeg',
    title: '2019年春季新品发布会第一场',
    date: '2021-03-21 18:00',
    id: 7283303,
    address: '国际会议中心',
    status: '进行中',
    has_sign_up: 0,
    sign_up_count: 10
  }

  onPageShow() {
    this.isLoading = true
    setTimeout(() => this.isLoading = false, 2000)
  }

  build() {
    Column() {
      if (this.isLoading) {
        LoadingProgress().color(Color.Blue).width(75)
      } else {
        Scroll(this.scroller) {
          Column() {
            Button('切换布局').onClick(() => {
              console.info("this.ListOrCard", this.ListOrCard)
              this.ListOrCard = !this.ListOrCard
              console.info("this.ListOrCard", this.ListOrCard)
            })
            ActiveItem({
              activeList: $activeList,
              bool: $ListOrCard
            })
          }
          .width('100%')
          .backgroundColor('#F3F4F5')
          .padding({ top: 10 })
        }
        .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
        .scrollBar(BarState.Auto) // 滚动条常驻显示
        .scrollBarColor(Color.Gray) // 滚动条颜色
        // .scrollBarWidth(10) // 滚动条宽度
        .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F5')
  }
}

@Component
struct ActiveItem {
  @Link activeList: Active
  @Link bool: boolean

  build() {
    Column() {
      if (this.bool) {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item, index) => {
          Column() {
            Row() {
              Image(this.activeList.image).width(100).height(100).objectFit(ImageFit.Cover).borderRadius(5)
              Column() {
                Text(this.activeList.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 })
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(this.activeList.address).fontSize(12)
                Row() {
                  Text(this.activeList.status)
                    .fontSize(12)
                    .fontColor(Color.White)
                    .padding({ left: 5, right: 5 })
                    .borderRadius(5)
                    .backgroundColor('red')
                  Text(`已报名 ${this.activeList.has_sign_up}/${this.activeList.sign_up_count}人`)
                    .fontSize(12)
                    .margin({ left: 5 })
                }
                .margin({ top: 10 })

                Text(this.activeList.date).fontSize(12).margin({ top: 5 })
              }
              .margin({ left: 10 })
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
          }
          .width('95%')
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#FFF')
          .padding(10)
          .margin({ bottom: 5 })
          .borderRadius(10)
        })
      } else {
        List() {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item, index) => {
            ListItem() {
              Column() {
                Image(this.activeList.image).width('100%').objectFit(ImageFit.Contain).borderRadius(5)
                Column() {
                  Text(this.activeList.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .margin({ bottom: 5 })
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(this.activeList.address).fontSize(12)
                  Row() {
                    Text(this.activeList.status)
                      .fontSize(12)
                      .fontColor(Color.White)
                      .padding({ left: 5, right: 5 })
                      .borderRadius(5)
                      .backgroundColor('red')
                    Text(`已报名 ${this.activeList.has_sign_up}/${this.activeList.sign_up_count}人`)
                      .fontSize(12)
                      .margin({ left: 5 })
                  }
                  .margin({ top: 10 })

                  Text(this.activeList.date).fontSize(12).margin({ top: 5 })
                }
                .width('100%')
                .margin({ top: 10 })
                .justifyContent(FlexAlign.Start)
                .alignItems(HorizontalAlign.Start)
              }
            }
            .backgroundColor('#FFF')
            .padding(5)
            .margin({
              bottom: 5,
              left: index % 2 == 0 ? 5 : 2.5,
              right: index % 2 == 1 ? 5 : 2.5,
            })
            .borderRadius(10)
          })
        }
        .lanes(2)
      }
    }
  }
}