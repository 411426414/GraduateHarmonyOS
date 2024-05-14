// import Axios from '@ohos/axios'
import { baseUrl } from '../common/config'
import { axios as Axios } from '../utils/request'


/**
 *  获取轮播图列表
 */
export function BannerList() {
  return Axios.get(`https://gzh.411426414.top/api/graduation/banner/list`)
}
// 获取已发布公告列表
export function NoticeList() {
  return Axios.get(`https://gzh.411426414.top/api/graduation/Notice/list`)
}
// 通过id查找公告
export function NoticeById() {
  return Axios.get(`https://gzh.411426414.top/api/graduation/notice/getnoticebyid`)
}
/**
 *  获取信息分类列表
 */
export function ClassInfoList() {
  return Axios.get(baseUrl + `/api/zixun/classification`)
}

export function getPyImg(data?) {
  return Axios.get(`https://shopro.411426414.top/api/py/getPyImg`, { params: data })
}


/*
const BASE_URL = "https://shopro.411426414.top"
  if (url.indexOf('https://') == -1) {
    url = BASE_URL + url
  }
  if (method == http.RequestMethod.GET) {
    let getParams = '?';
    for (let key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        const value = encodeURIComponent(data[key]); // 编码特殊字符
        getParams += `${encodeURIComponent(key)}=${value}&`;
      }
    }
    let params = getParams ? getParams.slice(0, -1) : ''; // 去除最后多余的 "&" 符号

    url = url + params
  }
  */