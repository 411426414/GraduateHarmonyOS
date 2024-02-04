import geoLocationManager from '@ohos.geoLocationManager';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import bundleManager from '@ohos.bundle.bundleManager';
import common from '@ohos.app.ability.common';

let getAddressesFromLocation: string = '1'
let getCountryCode: string = '2'
let reverseGeocodeReq: string = '3'
let getCurrentLocation: string = '4'
// 检测用户权限需要先获取Token，token是异步回调的
async function accessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
  let atManager = abilityAccessCtrl.createAtManager()
  let grantStatus: abilityAccessCtrl.GrantStatus

  let tokenID: number
  try {
    let bundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    tokenID = bundleInfo.appInfo.accessTokenId
  } catch (err) {
    console.log('OfficialLocationPageLocation 获取地理位置token失败')
  }

  try {
    grantStatus = await atManager.checkAccessToken(tokenID, permission)
  } catch (err) {
    console.log('获取地理位置token检测失败')
  }

  return grantStatus
}
// 获取token后，开始查询用户权限状态
async function checkPermission() {
  let permissions: Array<Permissions> = ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION']
  let locationStatus = await this.accessToken(permissions[0])
  let roximateyStatus = await this.accessToken(permissions[1])
  if (locationStatus == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED &&
  roximateyStatus == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
    console.log('OfficialLocationPageLocation 已经申请完权限了')
  } else {
    console.log('OfficialLocationPageLocation 需要申请权限')
    this.requestPermission()
  }
}
// 申请权限
function requestPermission() {
  let atManager = abilityAccessCtrl.createAtManager()
  let permissions: Array<Permissions> = ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION']
  atManager.requestPermissionsFromUser(getContext(this), permissions, (err, permissionResult) => {
    if (err) {
      console.log('OfficialLocationPageLocation 申请权限失败')
      return
    }

    let grantStatus: Array<number> = permissionResult.authResults
    let grantPermissions: Array<string> = permissionResult.permissions
    let length: number = grantStatus.length
    console.log('OfficialLocationPageLocation user permissioned length' + JSON.stringify(grantPermissions) + length)
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        console.log('OfficialLocationPageLocation user has agreed permissioned')
      } else {
        console.log('OfficialLocationPageLocation user has disagree permissioned')
        this.openPermissionSettings()
      }
    }
  })
}
// 跳转到权限设置页面
function openPermissionSettings() {
  let context = getContext(this) as common.UIAbilityContext
  let wantInfo = {
    action: 'action.settings.app.info',
    parameters: {
      settingsParamBundleName: 'com.example.myapplication'
    }
  }
  context.startAbility(wantInfo).then(() => {
    console.log('OfficialLocationPageLocation open setting page')
  }).catch((err) => {
    console.log('OfficialLocationPageLocation open setting page failed', JSON.stringify(err))
  })
}
// 权限完成后，开启定位
function startLocate() {
  this.checkPermission()
    .then(() => {
      let requestInfo = {
        'priority': 0x203,
        'scenario': 0x300,
        'timeInterval': 0,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location) => {
        console.log('OfficialLocationPageLocation change:data = ' + JSON.stringify(location))
      }
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange)
      } catch (err) {
        console.error("OfficialLocationPageLocation change errCode:" + err.code + ",errMessage:" + err.message)
      }

      try {
        //获取当前的地理位置
        geoLocationManager.getCurrentLocation((err, location) => {
          if (err) {
            console.log('OfficialLocationPageLocation getCurrentLocation err = ' + JSON.stringify(err))
          }
          if (location) {
            console.log('OfficialLocationPageLocation getCurrentLocation = ' + JSON.stringify(location))
            this.getCurrentLocation = JSON.stringify(location)
            //{"latitude":40,"longitude":116,"altitude":43.5,"accuracy":5,"speed":0,"timeStamp":1704176491,"direction":45,"timeSinceBoot":13563917977759,"additions":"","additionSize":0,"isFromMock":false}
            let latitude = location.latitude
            let longitude = location.longitude
            let maxItems = 1
            let reverseGeocodeReq = { 'latitude': latitude, 'longitude': longitude, 'maxItems': maxItems }
            this.reverseGeocodeReq = JSON.stringify(reverseGeocodeReq)

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

export default {
  getAddressesFromLocation,
  getCountryCode,
  reverseGeocodeReq,
  getCurrentLocation,
  accessToken,
  checkPermission,
  requestPermission,
  openPermissionSettings,
  startLocate,
}