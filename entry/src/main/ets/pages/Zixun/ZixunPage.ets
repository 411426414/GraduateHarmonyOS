import geoLocationManager from '@ohos.geoLocationManager';
import { LocateUtils } from '../../utils/LocateUtils';

@Entry
@Component
export default struct ZixunPage {
  @State message: string = '开始定位'
  @State getAddressesFromLocation: string = '1'
  @State getCountryCode: string = '2'
  @State reverseGeocodeReq: {
    latitude: number;
    longitude: number;
    maxItems: number;
  } = { latitude: 0, longitude: 0, maxItems: 0 }
  @State getCurrentLocation: string = '4'
  locateUtils = new LocateUtils()

  onPageShow() {
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.startLocate()
          })
        // Text(this.getAddressesFromLocation)
        // Text(this.getCountryCode)
        Text(`${JSON.stringify(this.reverseGeocodeReq)}`)
        Text(this.getCurrentLocation)
      }
      .width('100%')
    }
    .height('100%')
  }

  // 权限完成后，开启定位
  startLocate() {
    this.locateUtils.checkPermission()
      .then(() => {
        // let requestInfo = {
        //   'priority': 0x203,
        //   'scenario': 0x300,
        //   'timeInterval': 0,
        //   'distanceInterval': 0,
        //   'maxAccuracy': 0
        // };
        // let locationChange = (location) => {
        //   console.log('OfficialLocationPageLocation change:data = ' + JSON.stringify(location))
        // }
        // try {
        //   geoLocationManager.on('locationChange', requestInfo, locationChange)
        // } catch (err) {
        //   console.error("OfficialLocationPageLocation change errCode:" + err.code + ",errMessage:" + err.message)
        // }

        try {
          //获取当前的地理位置
          geoLocationManager.getCurrentLocation((err, location) => {
            if (err) {
              console.log('OfficialLocationPageLocation getCurrentLocation err = ' + JSON.stringify(err))
            }
            if (location) {
              console.log('OfficialLocationPageLocation getCurrentLocation = ' + JSON.stringify(location))
              this.getCurrentLocation = JSON.stringify(location)
              /**
               * {
               *  "latitude":40,
               *  "longitude":116,
               *  "altitude":43.5,
               *  "accuracy":5,
               *  "speed":0,
               *  "timeStamp":1704176491,
               *  "direction":45,
               *  "timeSinceBoot":13563917977759,
               *  "additions":"",
               *  "additionSize":0,
               *  "isFromMock":false
               * }
               */
              let latitude = location.latitude
              let longitude = location.longitude
              let maxItems = 1
              let reverseGeocodeReq = { 'latitude': latitude, 'longitude': longitude, 'maxItems': maxItems }
              this.reverseGeocodeReq = reverseGeocodeReq

              //根据坐标转化为地理描述
              geoLocationManager.getAddressesFromLocation(reverseGeocodeReq, (err, val) => {
                if (err) {
                  console.log('OfficialLocationPageLocation getAddressesFromLocation err = ' + JSON.stringify(err))
                  //{"code":3301300,"message":"BussinessError 3301300: Reverse geocoding query failed."}
                }
                if (val) {
                  console.log('OfficialLocationPageLocation getAddressesFromLocation = ' + JSON.stringify(val))
                  this.getAddressesFromLocation = JSON.stringify(val)
                }
              })

              //获取国家码
              geoLocationManager.getCountryCode((err, val) => {
                if (err) {
                  console.log('OfficialLocationPageLocation getCountryCode err = ' + JSON.stringify(err))
                }
                if (val) {
                  console.log('OfficialLocationPageLocation getCountryCode = ' + JSON.stringify(val))
                  this.getCountryCode = JSON.stringify(val)
                  //location getCountryCode = {"country":"CN","type":4}
                }
              })
            }
          })
        } catch (err) {
          console.log('OfficialLocationPageLocation getCurrentLocation catch err = ' + JSON.stringify(err))
        }
      })
      .catch(err => {
        console.error("OfficialLocationPageLocation permission errCode:" + err.code + ",errMessage:" + err.message)
      })
  }
}