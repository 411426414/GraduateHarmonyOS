import router from '@ohos.router'

@Entry
@Component
struct SensorListPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Column() {
        Text('重力传感器').fontSize(20).fontWeight(FontWeight.Bold)
        Text(`名称：gravity`)
        Text(`厂商：huawei`)
        Text(`唤醒型传感器：否`)
        Text(`耗电量：0.2mA`)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Color.White)
      .borderRadius(15)
      .margin(10)
      .padding(10)
      .width('95%')
      .onClick(() => {
        router.pushUrl({ url: 'pages/Sensor/GravitySensorPage' })
      })
    }
    .backgroundColor('#CCC')
    .width('100%')
    .height('100%')
  }
}