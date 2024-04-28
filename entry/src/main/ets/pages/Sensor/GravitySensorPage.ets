import sensor from '@ohos.sensor'

const flag = '传感器'

@Entry
@Component
struct GravitySensorPage {
  @State message: string = '监听加速度传感器的数据变化。'
  @State sensor: string = ''
  @State x: number = 0
  @State y: number = 0
  @State z: number = 0
  @State timestamp: number = 0

  build() {
    Column() {
      Row() {
        Image($r('app.media.img'))
          .width(75)
          .height(75).borderRadius(37.5).margin({ right: 10 })
        Column() {
          Text(`X：${this.x} m/s`).fontColor(Color.White)
          Text(`Y：${this.y} m/s`).fontColor(Color.White).margin({ top: 10, bottom: 10 })
          Text(`Z：${this.z} m/s`).fontColor(Color.White)
        }
        .margin({ top: 10, bottom: 10 })
      }
      .backgroundColor('#579872')
      .width('95%')
      .padding(10)
      .margin({ top: 10 })

      Column() {
        this.TextRow('传感器ID', '0')
        this.TextRow('传感器名称', 'gravity')
        this.TextRow('传感器类型', 'android.sensor.gravity')
        this.TextRow('厂商', 'huawei')
        this.TextRow('版本', '1')
        this.TextRow('解析度', '0.153 m/s')
        this.TextRow('耗电量', '0.2mA')
        this.TextRow('最大范围', '9.80665 m/s')
        this.TextRow('动态传感器', '否')
        this.TextRow('唤醒型传感器', '否')
        this.TextRow('报告方式', '固定的速率')
      }
      .margin({ top: 10 })
      .width('95%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TextRow(label: string, value: any) {
    Row() {
      Text(label).width('40%').fontColor('#767676')
      Text(value).width('60%').fontColor('#62927F')
    }
    .padding(10)
  }

  onPageShow() {
    let _this = this
    sensor.on(sensor.SensorType.SENSOR_TYPE_ID_GRAVITY, function (data) {
      _this.sensor = JSON.stringify(data)
      _this.x = data.x
      _this.y = data.y
      _this.z = data.z
    },
      { interval: 10000000 }
    )
  }
}