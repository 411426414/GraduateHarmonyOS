import { LocateUtils } from '../../utils/LocateUtils';
import geoLocationManager from '@ohos.geoLocationManager';

@Component
export default struct ZixunPage {
  locateUtils = new LocateUtils()
  @State message: string = '开始定位'
  @State getCurrentLocation: string = '1'
  @State getAddressesFromLocation: string = '2'

  aboutToAppear() {
    this.startLocate()
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
        Text("----- getCurrentLocation -----")
        Text(this.getCurrentLocation)
        Text('----- getAddressesFromLocation -----')
        Text(this.getAddressesFromLocation)
      }
      .width('100%')
    }
    .height('100%')
  }

  // 权限完成后，开启定位
  startLocate() {
    console.log('OfficialLocationPageLocation onPageShow')
    this.locateUtils.checkPermission()
      .then(() => {
        //获取当前的地理位置
        geoLocationManager.getCurrentLocation((err, location) => {
          if (err) {
            console.log('OfficialLocationPageLocation getCurrentLocation err = ' + JSON.stringify(err))
          }
          if (location) {
            console.log('OfficialLocationPageLocation getCurrentLocation = ' + JSON.stringify(location))
            this.getCurrentLocation = JSON.stringify(location)
            let latitude = location.latitude
            let longitude = location.longitude
            let reverseGeocodeReq = { 'latitude': latitude, 'longitude': longitude }
            // 根据坐标转化为地理描述
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
          }
        })
      })
      .catch(err => {
        console.error("OfficialLocationPageLocation permission errCode:" + err.code + ",errMessage:" + err.message)
      })
  }
}