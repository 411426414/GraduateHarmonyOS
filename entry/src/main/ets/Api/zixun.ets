import { baseUrl } from '../common/config'
import { axios as Axios } from '../utils/request'

/***
 * 获取信息列表
 * @param search  string  否  搜索条件
 * @param type  int  否  1:全部,2:热门,3:推荐,4:会员,5:免费,6:图片,7:音频,8:视频
 * @param page  int  否  页索引
 * @param pagesize  int  否  每页多少行
 */
export function ZixunInfoList(data?: {
  search: string
  type: number
  page: number
  pagesize: number
}) {
  return Axios.get(baseUrl + `/api/zixun/infolist`, { params: data })
}

/**
 * 信息详情
 * @param id  integer  是  信息ID
 */
export function ZixunInfoDetail(id) {
  return Axios.get(baseUrl + `/api/zixun/infodetail`, { params: { id } })
}
