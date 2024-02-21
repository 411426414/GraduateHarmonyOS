import { AllStationV1, getLccInfoByStationId, LccStationList, subscribeList4, subscribeV1 } from '../../Api/tramPage'
import { dataList, Tram } from '../../viewmodel/TramModel'
import promptAction from '@ohos.promptAction'
import EmptyComponent from '../../components/EmptyComponent'


const flagTag: string = '有轨电车'
const userId: number = 1233666


@Entry
@Component
export default struct TramPage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = 'sm';
  @State lccStationList: Tram[] = []
  @State lineInfoList: Tram[] = []
  @State currentIndex: number = 0
  @State TabBarData: string[] = ['离我最近', '我的关注', 'L1线路', 'L2线路', 'L3线路']
  @State isLoading: boolean = false
  @State longitude: number = 114.4126129031616211 // 经度
  @State latitude: number = 30.5023042637072754 // 维度

  aboutToAppear() {
    console.log(`${flagTag} aboutToAppear`)
    setTimeout(() => this.ChangeFun(), 500)
  }

  build() {
    Column() {
      if (this.isLoading) {
        LoadingProgress()
          .color('#0091ff')
          .width(50)
      } else {
        // Tabs组件
        TabsBar({
          currentIndex: $currentIndex,
          TabBarData: $TabBarData,
          Tram: $lccStationList,
          lineInfoList: $lineInfoList,
          longitude: $longitude,
          latitude: $latitude,
          Change: (index: number) => {
            this.currentIndex = index
            this.ChangeFun()
          }
        }).height('100%')
      }
    }
    .height('100%')
    .width('100%')
  }

  ChangeFun() {
    this.isLoading = true
    this.lineInfoList = []
    let index = this.currentIndex

    if (index === 0) {
      this.getClassInfoList()
    } else if (index === 1) {
      this.getSubscribeList4()
    } else if (index === 2 || index === 3 || index === 4) {
      let data = {
        longitude: this.longitude, //  经度
        latitude: this.latitude, //  维度
        lineNo: index - 1, //线路id
        status: '',
        stationId: '',
        userId
      }
      this.getAllStationV1(data)
    }
  }

  getClassInfoList() {
    let data = {
      longitude: this.longitude, //  经度
      latitude: this.latitude, //  维度
      status: 1, // 状态
      userId, // 用户id
    }
    LccStationList(data)
      .then(res => {
        this.lccStationList = res.data
        // console.info(`${flagTag} 最近列表 success`, JSON.stringify(this.lccStationList))
      })
      .catch(err => {
        console.info(`${flagTag} 最近列表 fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  getSubscribeList4() {
    subscribeList4(1233666)
      .then(res => {
        this.lccStationList = res.data
        // console.info(`${flagTag} 我的关注列表 success`, JSON.stringify(this.lccStationList))
      })
      .catch(err => {
        console.info(`${flagTag} 我的关注列表 fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }

  getAllStationV1(data) {
    console.info("data", JSON.stringify(data))
    AllStationV1(data)
      .then(res => {
        this.lccStationList = [res.data.stationInfo]
        this.lineInfoList = res.data.lineInfo

        console.info(`${flagTag} L${data.lineNo}线路 success`, JSON.stringify(this.lccStationList))
        console.info(`${flagTag} L${data.lineNo}线路 lineInfoList success`, JSON.stringify(this.lineInfoList))
      })
      .catch(err => {
        console.info(`${flagTag} L${data.lineNo}线路 fail`, JSON.stringify(err))
      })
      .finally(() => {
        this.isLoading = false
      })
  }
}

@Component
struct TabsBar {
  @Link currentIndex: number
  @Link TabBarData: Array<string>
  @Link Tram: Array<Tram>
  @Link lineInfoList: Array<Tram>
  @Link longitude: number
  @Link latitude: number

  build() {
    Stack() {
      Column() {
        // Text(`currentIndex: ${this.currentIndex}`)
        Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
          ForEach(this.TabBarData, (item: string) => {
            TabContent() {
              Column() {
                TramContentList({
                  longitude: $longitude,
                  latitude: $latitude,
                  TramList: $Tram,
                  lineInfoList: $lineInfoList,
                  currentIndex: $currentIndex,
                  Subscribe: () => this.Change(this.currentIndex)
                })
                  .height('100%')
                  .backgroundColor('#ffd2cfcf')
              }
            }.tabBar(item)
          }, (item) => JSON.stringify(item))
        }
        .barWidth('95%')
        .barHeight('7.2%')
        .barMode(BarMode.Fixed)
        .scrollable(true)
        .barMode(BarMode.Scrollable)
        .onChange((index: number) => {
          this.Change(index)
        })
      }
      .justifyContent(FlexAlign.Start)
    }.height('100%')
  }

  // 父组件传递一个事件函数,当子组件的商品被点击时,调用该事件函数,并把被点击的商品传递给它
  private Change? = (index: number) => {
  }
}

@Component
struct TramContentList {
  @Link TramList: Array<Tram>
  @Link lineInfoList: Array<Tram>
  @Link currentIndex: number
  @Link longitude: number
  @Link latitude: number

  build() {
    Column() {
      if (this.TramList.length > 0) {
        List({ space: 8 }) {
          ForEach(this.TramList, (item: Tram, index: number) => {
            ListItem() {
              Column() {
                Row() {
                  Text(item.stationName)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Image(item.flag ? $r('app.media.hart_sel') : $r('app.media.hart'))
                    .width(20)
                    .height(20)
                    .onClick(() => {
                      let data = {
                        type: item.flag ? 'remove' : 'add', // 类型：add: 关注; remove: 取消关注
                        stationIds: item.stationId, // 站点id 77
                        userId // 用户id 1233666
                      }
                      this.setSubscribeV1(data)
                    })
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width('100%')

                if (item.dataList)
                Column() {
                  ForEach(item.dataList, (dataListItem: dataList, dataListIndex: number) => {
                    if (dataListIndex != 0) {
                      Divider()
                        .margin({ top: 15, bottom: 15 })
                    }

                    Row() {
                      Row() {
                        Text(dataListItem.lineName)
                          .fontSize(14)
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#666')
                        Text(`开往${dataListItem.endStation}`)
                          .fontSize(14)
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#666')
                      }
                      .width('40%')

                      Text('换向')
                        .onClick(() => {
                          if (!this.lineInfoList.length) {

                            let data = {
                              stationId: item.stationId === item.otherId ? item.stationId : item.otherId, //  站id 78
                              userId, //  用户id 1233666
                              lineNo: item.lineId, //  线路编号 2
                              status: item.status == '1' ? 1 : 2, //  状态 2
                            }
                            getLccInfoByStationId(data)
                              .then(res => {
                                promptAction.showToast({ message: '换向成功', })
                                this.TramList[index] = res.data
                                // console.info(`${flagTag} 换向 success`, JSON.stringify(res.data))
                              })
                              .catch(err => {
                                console.info(`${flagTag} 换向 fail`, JSON.stringify(err))
                              })
                          } else {
                            let data = {
                              longitude: this.longitude, //  经度
                              latitude: this.latitude, //  维度
                              lineNo: item.lineId, //线路id

                              status: item.status == '1' ? 2 : 1,
                              stationId: item.otherId,
                              userId
                            }
                            AllStationV1(data)
                              .then(res => {
                                this.TramList = [res.data.stationInfo]
                                this.lineInfoList = res.data.lineInfo

                                console.info(`${flagTag} L${data.lineNo}线路 success`, JSON.stringify(this.TramList))
                                console.info(`${flagTag} L${data.lineNo}线路lineInfoList success`, JSON.stringify(this.lineInfoList))
                              })
                              .catch(err => {
                                console.info(`${flagTag} L${data.lineNo}线路 fail`, JSON.stringify(err))
                              })
                          }
                        })
                        .width('25%')


                      Text(dataListItem.minute)
                        .width('25%')
                        .fontSize(14)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#38C0FE')
                        .textAlign(TextAlign.End)
                    }
                    .justifyContent(FlexAlign.SpaceBetween)
                    .width('100%')

                    Row() {
                      Row() {
                        Text(dataListItem.downRunTime)
                          .fontSize(12)
                          .fontColor('#777')
                        Divider()
                          .height(12)
                          .width(2)
                          .margin({ left: 10, right: 10 })
                          .backgroundColor('#777')
                        Text(`票价${dataListItem.ticketPrice}元`)
                          .fontSize(12)
                          .fontColor('#777')
                      }

                      if (dataListItem.nextArriveTime != '---')
                        Text(`下辆${dataListItem.nextArriveTime}`)
                          .fontSize(14)
                          .fontColor('#777')
                    }
                    .justifyContent(FlexAlign.SpaceBetween)
                    .width('100%')
                    .margin({ top: 15 })
                  })
                }
                .margin({ top: 15 })
              }
              .width('95%')
              .borderRadius(10)
              .margin({
                top: index == 0 ? 10 : 0,
                left: 10,
                right: 10,
                bottom: index == this.TramList.length - 1 ? 10 : 0
              })
              .padding({ left: 15, top: 15, bottom: 15, right: 15 })
              .backgroundColor(Color.White)
            }.swipeAction({ end: this.DeleteButton(item) })
          })
        }
      } else {
        EmptyComponent()
      }
      if (this.lineInfoList.length > 0) {
        Column() {
          List({ space: 8 }) {
            ForEach(this.lineInfoList, (item: Tram) => {
              ListItem() {
                Text(item.stationName)
                  .width(20)
                  .textAlign(TextAlign.Center)
                  .margin({ left: 5, right: 5 })
                  .fontWeight(this.TramList[0].stationId == item.stationId ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(this.TramList[0].stationId == item.stationId ? '#01A0C6' : '#000')
                  .onClick(() => {
                    let data = {
                      longitude: this.longitude, //  经度
                      latitude: this.latitude, //  维度
                      lineNo: item.lineId, //线路id

                      status: item.status,
                      stationId: item.stationId,
                      userId
                    }
                    AllStationV1(data)
                      .then(res => {
                        this.TramList = [res.data.stationInfo]
                        this.lineInfoList = res.data.lineInfo

                        console.info(`${flagTag} L${data.lineNo}线路 success`, JSON.stringify(this.TramList))
                        console.info(`${flagTag} L${data.lineNo}线路lineInfoList success`, JSON.stringify(this.lineInfoList))
                      })
                      .catch(err => {
                        console.info(`${flagTag} L${data.lineNo}线路 fail`, JSON.stringify(err))
                      })
                  })
              }
            }, (item) => JSON.stringify(item))
          }
          .width('90%')
          .listDirection(Axis.Horizontal)
        }
        .padding({ top: 15 })
        .width('95%')
        .height(175)
        .borderRadius(10)
        .backgroundColor(Color.White)
      }
    }
  }

  @Builder DeleteButton(item: Tram) {
    Button() {
      Image($r('app.media.img'))
        .width(20)
        .fillColor(Color.White)
        .onClick(() => {
          promptAction.showToast({
            message: item.stationName
          })
        })
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
  }

  setSubscribeV1(data) {
    subscribeV1(data)
      .then(() => {
        promptAction.showToast({
          message: data.type === 'add' ? '关注成功' : '取消关注成功',
        })
        this.Subscribe()
        // console.info(`${flagTag} 关注 success`, JSON.stringify(res.data))
      })
      .catch(err => {
        console.info(`${flagTag} 关注 fail`, JSON.stringify(err))
      })
  }

  private Subscribe? = () => {
  }
}