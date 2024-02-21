import sensor from '@ohos.sensor'

const flag = '传感器'

@Entry
@Component
struct SensorPage {
  @State message: string = '监听加速度传感器的数据变化。如果多次调用该接口，仅最后一次调用生效。'
  @State sensor: string = ''

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            sensor.on(sensor.SensorType.SENSOR_TYPE_ID_ACCELEROMETER,
              function (data) {
                this.sensor = JSON.stringify(data)
                console.info('Accelerometer sensor data changed: ' + JSON.stringify(data));
                console.info('X-coordinate component: ' + data.x);
                console.info('Y-coordinate component: ' + data.y);
                console.info('Z-coordinate component: ' + data.z);
              },
              { interval: 10000000 }
            );
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}