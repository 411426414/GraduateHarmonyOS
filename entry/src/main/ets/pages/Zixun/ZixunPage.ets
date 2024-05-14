import { ClassInfoList } from '../../Api/homePage'
import { ZixunInfoList } from '../../Api/zixun'
import { ClassInfo, ZixunInfo } from '../../viewmodel/BannerModel'
import { baseUrl } from '../../common/config'
import router from '@ohos.router'

const flagTag: string = '咨询页'

@Entry
@Component
export default struct ZixunPage {
  @State classInfoList: Array<ClassInfo> = []
  @State isLoading: boolean = false
  @State currentIndex: number = 0
  @State ZixunInfoList: Array<ZixunInfo> = []

  aboutToAppear() {
    this.getClassInfoList()
    this.getZixunInfoList()
  }

  onPageShow() {
    this.isLoading = true
    this.getClassInfoList()
    this.getZixunInfoList()
  }

  build() {
    Column({ space: 8 }) {
      if (this.isLoading) {
        LoadingProgress().color('#0091ff').width(50)
      }
      Stack() {
        Column() {
          // Tabs组件
          Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
            ForEach(this.classInfoList, (item: ClassInfo) => {
              TabContent() {
                if (this.isLoading) {
                  LoadingProgress().color('#0091ff').width(50)
                } else {
                  this.buildClassInfoList()
                }
              }.tabBar(item.name)
            }, (item) => item.id)
          }
          .barWidth('95%')
          .barHeight('7.2%')
          .barMode(BarMode.Fixed)
          .scrollable(true)
          .barMode(BarMode.Scrollable)
          .onChange((index: number) => this.currentIndex = index)
        }.justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Start)
      }.height('100%')
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F2F3F5')
  }

  @Builder
  buildClassInfoList() {
    Column() {
      List({ space: 8 }) {
        ForEach(this.ZixunInfoList, (item: ZixunInfo, index: number) => {
          ListItem() {
            Column() {
              Text(item.title).fontSize(16).maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })

              if (item.videofile != '') {
                Video({
                  src: baseUrl + item.videofile,
                  previewUri: baseUrl + item.coverimage
                })
                  .width('100%')
                  .height(200)
              }
              if (item.audiofile != '') {
                Text(baseUrl + item.audiofile)
              }
              if (item.coverimage != '' && item.videofile == '') {
                Image(baseUrl + item.coverimage).width('100%').borderRadius(7).padding({ top: 10 })
              }
              if (Number(item.price) > 0) {
                Text('￥' + item.price + '元').fontSize(16).fontColor('#F00').padding({ top: 10 })
              }
              Row() {
                // Image()
                Text('浏览量:' + item.viewcount + '次').fontSize(14).fontColor('#999999')
                Column() {
                }.width(1).height(16).backgroundColor('#999999').margin({ left: 5, right: 5 })

                Text(item.publishtime).fontSize(14).fontColor('#999999')
              }.padding({ top: 10 })
            }
            .width('100%')
            .borderRadius(10)
            .backgroundColor('#FFFFFF')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 10, right: 10, top: 10, bottom: 10 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/Zixun/ZixunDetailPage',
                params: {
                  zixunId: item.id
                }
              })
            })
          }
        })
      }
    }
    .backgroundColor('#F2F2F2')
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10, bottom: 10 })
  }

  getClassInfoList() {
    ClassInfoList().then(res => {
      this.classInfoList = res.data
    }).finally(() => this.isLoading = false)
  }

  getZixunInfoList() {
    ZixunInfoList().then(res => {
      this.ZixunInfoList = res.data
      console.log("res:", JSON.stringify(res))
    }).finally(() => this.isLoading = false)
  }
}