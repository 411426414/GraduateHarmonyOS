import { AllStationV1, getLccInfoByStationId, LccStationList, subscribeList4, subscribeV1 } from '../../Api/tramPage'
import { dataList, Tram } from '../../viewmodel/TramModel'
import promptAction from '@ohos.promptAction'
import EmptyComponent from '../../components/EmptyComponent'
import { LocateUtils } from '../../utils/LocateUtils'
import geoLocationManager from '@ohos.geoLocationManager'

const flagTag: string = '有轨电车'
const userId: number = 1233666

@Entry
@Component
export default struct TramPage1 {
  locateUtils = new LocateUtils()
  @StorageProp('currentDeviceSize') currentDeviceSize: string = 'sm';
  @State lccStationList: Tram[] = []
  @State lineInfoList: Tram[] = []
  @State currentIndex: number = 0
  @State TabBarData: string[] = ['离我最近', '我的关注', 'L1线路', 'L2线路', 'L3线路']
  @State isLoading: boolean = false
  @State longitude: number = 114.4126129031616211 // 经度
  @State latitude: number = 40.5023042637072754 // 维度
  @State getCurrentLocation: string = ''

  aboutToAppear() {
    console.log(`${flagTag} aboutToAppear`)
    // this.startLocate()
    setTimeout(() => this.ChangeFun(), 500)
  }

  // 权限完成后，开启定位
  startLocate() {
    this.locateUtils.checkPermission()
      .then((res) => {
        geoLocationManager.getCurrentLocation((err, location) => {
          if (location) {
            this.latitude = location.latitude
            this.longitude = location.longitude
          }
        })
      })
      .catch(err => {
        promptAction.showToast({
          message: "OfficialLocationPageLocation permission errCode:" + err.code + ",errMessage:" + err.message
        })
      })
  }

  build() {
    Column() {
      // if (this.isLoading) {
      //   LoadingProgress().color('#0091ff').width(50)
      // } else {
      this.TabsBar()
      // }
    }.height('100%').width('100%')
  }

  ChangeFun() {
    // this.startLocate()
    this.isLoading = true
    this.lccStationList = []
    this.lineInfoList = []
    let index = this.currentIndex
    switch (index) {
      case 0:
        console.log("最近:", 0)
        this.getClassInfoList()
        break;
      case 1:
        this.getSubscribeList4()
        break;
      case 2:
      case 3:
      case 4:
        this.getAllStationV1(index - 1)
        break;
    }
  }

  getClassInfoList() {
    let data = {
      longitude: this.longitude, //  经度
      latitude: this.latitude, //  维度
      status: 1, // 状态
      userId, // 用户id
    }
    console.log("data:", JSON.stringify(data))
    LccStationList(data).then(res => this.lccStationList = res.data).finally(() => this.isLoading = false)
  }

  getSubscribeList4() {
    subscribeList4(userId).then(res => this.lccStationList = res.data).finally(() => this.isLoading = false)
  }

  getAllStationV1(lineNo) {
    let data = {
      longitude: this.longitude, //  经度
      latitude: this.latitude, //  维度
      lineNo, //线路id
      status: '',
      stationId: '',
      userId
    }
    AllStationV1(data).then(res => {
      this.lccStationList = [res.data.stationInfo];
      this.lineInfoList = res.data.lineInfo;
    }).finally(() => this.isLoading = false)
  }

  setSubscribeV1(data) {
    subscribeV1(data).then(() => {
      promptAction.showToast({
        message: data.type === 'add' ? '关注成功' : '取消关注成功',
      })
      this.ChangeFun()
    })
  }

  @Builder
  TabsBar() {
    Stack() {
      Column() {
        Text(`longitude: ${this.longitude}`)
        Text(`latitude: ${this.latitude}`)
        Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
          ForEach(this.TabBarData, (item: string) => {
            TabContent() {
              if (this.isLoading) {
                LoadingProgress().color('#0091ff').width(50)
              } else {
                Column() {
                  this.TramContentList(
                    this.longitude,
                    this.latitude,
                    this.lccStationList,
                    this.lineInfoList
                  )
                }
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
        })
      }
      .justifyContent(FlexAlign.Start)
    }.height('100%')
  }

  @Builder
  TramContentList(longitude: number, latitude: number, TramList: Tram[], lineInfoList: Tram[]) {
    Column() {
      if (TramList.length > 0) {
        List({ space: 8 }) {
          ForEach(TramList, (item: Tram, index: number) => {
            ListItem() {
              Column() {
                Row() {
                  Text(item.stationName + ' ' + item.stationId + ' ' + item.otherId)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                  Image(item.flag ? $r('app.media.hart_sel') : $r('app.media.hart')).width(20).height(20)
                    .onClick(() => {
                      this.setSubscribeV1({
                        userId, // 用户id 1233666
                        stationIds: item.stationId, // 站点id 77
                        type: item.flag ? 'remove' : 'add', // 类型：add: 关注; remove: 取消关注
                      })
                    })
                }.justifyContent(FlexAlign.SpaceBetween).width('100%')

                if (item.dataList)
                Column() {
                  ForEach(item.dataList, (dataListItem: dataList, dataListIndex: number) => {
                    if (dataListIndex != 0) {
                      Divider().margin({ top: 15, bottom: 15 })
                    }
                    Row() {
                      Row() {
                        Text(dataListItem.lineName).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#666')
                        Text(`开往${dataListItem.endStation}`).fontWeight(FontWeight.Bold).fontColor('#666')
                      }.width('40%')

                      Text('换向' + item.status)
                        .onClick(() => {
                          if (!lineInfoList.length) {
                            let data = {
                              stationId: item.otherId, //item.stationId === item.otherId ? item.stationId : item.otherId, //  站id 78
                              userId, //  用户id 1233666
                              lineNo: item.lineId, //  线路编号 2
                              // status: item.status == '1' ? 1 : 2, //  状态 2
                            }
                            console.log("data:", JSON.stringify(data))
                            getLccInfoByStationId(data)
                              .then(res => {
                                promptAction.showToast({ message: '换向成功' })
                                TramList[index] = res.data
                                this.lccStationList = TramList
                              })
                              .catch(err => {
                                promptAction.showToast({ message: '换向失败' })
                                console.log("err:", JSON.stringify(err))
                              })
                          } else {
                            /*let data = {
                              longitude, //  经度
                              latitude, //  维度
                              lineNo: item.lineId, //线路id
                              status: item.status == '1' ? 2 : 1,
                              stationId: item.otherId,
                              userId
                            }
                            console.log("data:", JSON.stringify(data))
                            AllStationV1(data)
                              .then(res => {
                                this.lccStationList[index] = res.data
                                lineInfoList = res.data.lineInfo
                              })
                              .catch(err => {
                                promptAction.showToast({ message: '换向失败' })
                                console.log("err:", JSON.stringify(err))
                              })*/
                          }
                        }).width('25%')
                      Text(dataListItem.minute)
                        .width('25%')
                        .fontSize(14)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#38C0FE')
                        .textAlign(TextAlign.End)
                    }.justifyContent(FlexAlign.SpaceBetween).width('100%')

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
                }
                .margin({ top: 15 })
              }
              .width('95%')
              .borderRadius(10)
              .margin({
                top: index == 0 ? 10 : 0,
                left: 10,
                right: 10,
                bottom: index == TramList.length - 1 ? 10 : 0
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
                  .fontWeight(TramList[0].stationId == item.stationId ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(TramList[0].stationId == item.stationId ? '#01A0C6' : '#000')
                  .onClick(() => {
                    let data = {
                      longitude: longitude, //  经度
                      latitude: latitude, //  维度
                      lineNo: item.lineId, //线路id
                      status: item.status,
                      stationId: item.stationId,
                      userId
                    }
                    AllStationV1(data).then(res => {
                      TramList = [res.data.stationInfo]
                      lineInfoList = res.data.lineInfo
                    })
                  })
              }
            }, (item) => JSON.stringify(item))
          }.width('90%').listDirection(Axis.Horizontal)
        }
        .padding({ top: 15 })
        .width('95%')
        .height(175)
        .borderRadius(10)
        .backgroundColor(Color.White)
      }
    }.height('100%').backgroundColor('#ffd2cfcf')
  }

  @Builder
  DeleteButton(item: Tram) {
    Button() {
      Image($r('app.media.img'))
        .width(20)
        .fillColor(Color.White)
        .onClick(() => promptAction.showToast({ message: item.stationName }))
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
  }
}