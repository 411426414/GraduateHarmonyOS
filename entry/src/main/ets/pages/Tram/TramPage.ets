import promptAction from '@ohos.promptAction'
import { LocateUtils } from '../../utils/LocateUtils'
import geoLocationManager from '@ohos.geoLocationManager'
import { dataList, Tram } from '../../viewmodel/TramModel'
import EmptyComponent from '../../components/EmptyComponent'
import { AllStationV1, getLccInfoByStationId, LccStationList, subscribeList4, subscribeV1 } from '../../Api/tramPage'

const flagTag: string = '有轨电车'
const userId: number = 1233666

@Entry
@Component
export default struct TramPage {
  locateUtils = new LocateUtils()
  @StorageProp('currentDeviceSize') currentDeviceSize: string = 'sm';
  @State lccStationList: Tram[] = []
  @State lineInfoList: Tram[] = []
  @State currentIndex: number = 0
  @State initialIndex: number = 9 // 初始化时默认滑动到第一个列表项
  @State TabBarData: string[] = ['离我最近', '我的关注', 'L1线路', 'L2线路', 'L3线路']
  @State isLoading: boolean = true
  @State isClickChange: boolean = false
  @State longitude: number = 114.40169962800945 // 114.4126129031616211 // 经度
  @State latitude: number = 30.45788424996014 // 30.5022042637072754 // 维度

  aboutToAppear() {
    this.startLocate()
    this.ChangeFun()
  }

  build() {
    Column() {
      Stack() {
        Column() {
          // Tabs组件
          Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
            ForEach(this.TabBarData, (item: string) => {
              TabContent() {
                if (this.isLoading) {
                  LoadingProgress().color('#0091ff').width(50)
                } else {
                  this.TramContentList()
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
            this.currentIndex = index
            this.ChangeFun()

            this.isClickChange = false
          })
        }.justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Start)
      }.height('100%')
    }.height('100%').width('100%')
  }

  @Builder
  TramContentList() {
    Column() {
      if (this.lccStationList.length > 0) {
        List({ space: 8 }) {
          ForEach(this.lccStationList, (item: Tram, index: number) => {
            ListItem() {
              Column() {
                Row() {
                  Text(item.stationName).fontSize(16).fontWeight(FontWeight.Bold)
                  Image(item.flag ? $r('app.media.hart_sel') : $r('app.media.hart'))
                    .width(20)
                    .height(20)
                    .onClick(() => {
                      this.setSubscribeV1({
                        type: item.flag ? 'remove' : 'add', // 类型：add: 关注; remove: 取消关注
                        stationIds: item.stationId, // 站点id 77
                        userId // 用户id 1233666
                      })
                    })
                }.justifyContent(FlexAlign.SpaceBetween).width('100%')

                if (item.dataList)
                Column() {
                  ForEach(item.dataList, (dataListItem: dataList, dataListIndex: number) => {
                    if (dataListIndex != 0)
                      Divider().margin({ top: 15, bottom: 15 })
                    Row() {
                      Row() {
                        Text(dataListItem.lineName).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#666')
                        Text(`开往${dataListItem.endStation}`)
                          .fontSize(14)
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#666')
                      }
                      .width('40%')
                      .onClick(() => {
                        this.isClickChange = true
                        this.currentIndex = Number(dataListItem.lineId) + 1
                        this.getAllStationV1({
                          longitude: this.longitude, //  经度
                          latitude: this.latitude, //  维度
                          lineNo: item.lineId, //线路id
                          status: item.status,
                          stationId: item.stationId,
                          userId,
                        })
                      })

                      if (item.stationId != item.otherId)
                        Text('换向')
                          .onClick(() => {
                            if (!this.lineInfoList.length) {
                              let data = {
                                stationId: item.stationId === item.otherId ? item.stationId : item.otherId, //  站id 78
                                userId, //  用户id 1233666
                                lineNo: item.lineId, //  线路编号 2
                                status: item.status == '1' ? 1 : 2, //  状态 2
                              }
                              getLccInfoByStationId(data).then(res => {
                                promptAction.showToast({ message: '换向成功', })
                                this.lccStationList[index] = res.data
                              }).catch(err => console.info(`${flagTag} 换向 fail`, JSON.stringify(err)))
                            } else {
                              let data = {
                                longitude: this.longitude, //  经度
                                latitude: this.latitude, //  维度
                                lineNo: item.lineId, //线路id
                                status: item.status == '1' ? 2 : 1,
                                stationId: item.otherId,
                                userId
                              }
                              AllStationV1(data).then(res => {
                                this.lccStationList = [res.data.stationInfo]
                                this.lineInfoList = res.data.lineInfo
                              }).catch(err => console.info(`${flagTag} L${data.lineNo}线路 fail`, JSON.stringify(err)))
                            }
                          }).width('25%')
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
                        Text(dataListItem.downRunTime).fontSize(12).fontColor('#777')
                        Divider().height(12).width(2).margin({ left: 10, right: 10 }).backgroundColor('#777')
                        Text(`票价${dataListItem.ticketPrice}元`).fontSize(12).fontColor('#777')
                      }

                      if (dataListItem.nextArriveTime != '---')
                        Text(`下辆${dataListItem.nextArriveTime}`).fontSize(14).fontColor('#777')
                    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({ top: 15 })
                  })
                }.margin({ top: 15 })
              }
              .width('95%')
              .borderRadius(10)
              .margin({
                top: index == 0 ? 10 : 0,
                left: 10,
                right: 10,
                bottom: index == this.lccStationList.length - 1 ? 10 : 0
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
          List({ space: 8, initialIndex: this.initialIndex - 5 }) {
            ForEach(this.lineInfoList, (item: Tram, index: number) => {
              ListItem() {
                Text(item.stationName)
                  .width(17)
                  .textAlign(TextAlign.Center)
                  .margin({ left: 5, right: 5 })
                  .fontWeight(this.lccStationList[0].stationId == item.stationId ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(this.lccStationList[0].stationId == item.stationId ? '#01A0C6' : '#000')
                  .onClick(() => {
                    this.getAllStationV1({
                      longitude: this.longitude, //  经度
                      latitude: this.latitude, //  维度
                      lineNo: item.lineId, //线路id
                      status: item.status,
                      stationId: item.stationId,
                      userId,
                    })
                  })
              }

              // .backgroundColor(index % 2 == 0 ? '#01A0C6' : '#000')
            }, (item) => JSON.stringify(item))
          }.width('90%').listDirection(Axis.Horizontal)
        }
        .padding({ top: 15 })
        .width('95%')
        .height(175)
        .borderRadius(10)
        .backgroundColor(Color.White)
      }
    }.height('100%').backgroundColor('#fff3eeee')
  }

  // 权限完成后，开启定位
  startLocate() {
    this.locateUtils.checkPermission().then(() => {
      geoLocationManager.getCurrentLocation((_err, location) => {
        if (location) {
          this.latitude = location.latitude
          this.longitude = location.longitude
        }
      })
    }).catch(err => {
      promptAction.showToast({
        message: "OfficialLocationPageLocation permission errCode:" + err.code + ",errMessage:" + err.message
      })
    })
  }

  ChangeFun() {
    this.startLocate()
    this.isLoading = true
    this.lineInfoList = []
    let index = this.currentIndex
    if (!this.isClickChange)
      if (index === 0) {
        this.getClassInfoList()
      } else if (index === 1) {
        this.getSubscribeList4()
      } else if (index === 2 || index === 3 || index === 4) {
        this.getAllStationV1({
          longitude: this.longitude, //  经度
          latitude: this.latitude, //  维度
          lineNo: index - 1, //线路id
          status: '',
          stationId: '',
          userId
        })
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
      .then(res => this.lccStationList = res.data)
      .catch(err => console.info(`${flagTag} 最近列表 fail`, JSON.stringify(err)))
      .finally(() => this.isLoading = false)
  }

  getSubscribeList4() {
    subscribeList4(1233666)
      .then(res => this.lccStationList = res.data)
      .catch(err => console.info(`${flagTag} 我的关注列表 fail`, JSON.stringify(err)))
      .finally(() => this.isLoading = false)
  }

  getAllStationV1(data) {
    console.log("data:", JSON.stringify(data))
    AllStationV1(data)
      .then(res => {
        this.lccStationList = [res.data.stationInfo]
        this.lineInfoList = res.data.lineInfo
        this.lineInfoList.forEach((item, index) => {
          if (item.stationId == this.lccStationList[0]['stationId']) {
            this.initialIndex = index + 1
            console.log("this.initialIndex:", this.initialIndex)
          }
        })
      })
      .catch(err => console.info(`${flagTag} L${data.lineNo}线路 fail`, JSON.stringify(err)))
      .finally(() => this.isLoading = false)
  }

  setSubscribeV1(data) {
    subscribeV1(data)
      .then(() => {
        promptAction.showToast({ message: data.type === 'add' ? '关注成功' : '取消关注成功' })
        this.ChangeFun()
      })
      .catch(err => console.info(`${flagTag} 关注 fail`, JSON.stringify(err)))
  }

  @Builder
  DeleteButton(item: Tram) {
    Button() {
      Image($r('app.media.img')).width(20).fillColor(Color.White)
        .onClick(() => promptAction.showToast({ message: item.stationName }))
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
  }
}