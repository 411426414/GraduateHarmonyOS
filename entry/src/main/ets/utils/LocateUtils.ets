import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'
import bundleManager from '@ohos.bundle.bundleManager'
import common from '@ohos.app.ability.common'

class LocateUtils {
  // 检测用户权限需要先获取Token，token是异步回调的
  async accessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
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
  async checkPermission() {
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
  requestPermission() {
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
  openPermissionSettings() {
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
}

export { LocateUtils };