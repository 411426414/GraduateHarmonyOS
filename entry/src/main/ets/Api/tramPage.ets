import { baseUrl } from '../common/config'
import { axios as Axios } from '../utils/request'

/**
 * 查看站点信息：大吕路，城铁汤逊湖-》光谷植物园
 * stationId  int  否  站id 78
 * userId  int  否  用户id 1233666
 * lineNo  int  否  线路编号 2
 * status  int  否  状态 2
 * */
export function getLccInfoByStationId(data?) {
  return Axios.get(baseUrl + `/api/whyg/getLccInfoByStationId`, { params: data })
}
/**
 * 首页进入l1交路:线路id传1，首页进入l2交路:线路id传2，查询某站台：传站id /api/whyg/getAllStationV1
 * longitude  int  否  经度 114.4126129031616211
 * latitude  int  否  维度 30.5023042637072754
 * lineNo  int  否  线路id 1
 * status  int  否  状态 1
 * stationId  int  否  站id 1233666
 * userId  int  否  用户id 1233666
 * */
export function AllStationV1(data) {
  return Axios.get(baseUrl + `/api/whyg/getAllStationV1`, { params: data })
}
/**
 * 我的关注列表 /api/whyg/subscribeList4
 * userId  int  否  用户id 1233666
 **/
export function subscribeList4(userId) {
  return Axios.get(baseUrl + `/api/whyg/subscribeList4?userId=${userId}`)
}
/**
 * 最近列表 /api/whyg/getLccStationList
 * longitude  int  否  经度 114.3216781616211
 * latitude  int  否  维度 30.37558937072754
 * status  int  否  状态 1
 * userId  int  否  用户id 1233666
 */
export function LccStationList(data?) {
  return Axios.get(baseUrl + `/api/whyg/getLccStationList`, { params: data })
}
/**
 * 关注 / 取消关注 /api/whyg/subscribeV1
 * type  int  否  类型：add: 关注; remove: 取消关注
 * stationIds  int  否  站点id 77
 * userId  int  否  用户id 1233666
 **/
export function subscribeV1(data?) {
  return Axios.get(baseUrl + `/api/whyg/subscribeV1`, { params: data })
}