import { gzhBaseUrl } from '../common/config'
import { axios as Axios } from '../utils/request'

// 会员登录
export function userLogin(data?) {
  return Axios.post(gzhBaseUrl + `/api/user/login`, data)
}

// 会员中心
export function userIndex() {
  return Axios.get(gzhBaseUrl + `/api/user/index`)
}
// 获取个人信息
export function userInfo() {
  return Axios.post(gzhBaseUrl + `/api/graduation/usercenter/userinfo`)
}

// 修改个人信息
export function editUserInfo(data) {
  return Axios.post(gzhBaseUrl + `/api/graduation/usercenter/edituserinfo`, data)
}
