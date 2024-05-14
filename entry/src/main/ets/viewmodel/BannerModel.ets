export class Banner {
  id?: number
  title?: string
  coverimage?: string
  type?: string
  briefcontent?: string
  exhibits_id?: number
  status?: string
  weigh?: number
  createtime?: number
  updatetime?: number
  status_text?: string
}

export class Notice {
  id?: number
  title?: string
  shortdesc?: string
  publiserby?: string
  briefcontent?: string
  publishdate?: string
  createtime?: number
  publishdata_text?: string
}

export class ClassInfo {
  id?: number
  name?: string
  key?: string
  status?: string
  wigth?: number
  createtime?: number
  updatetime?: number
  status_text?: string
}

export class ZixunInfo {
  id?: number
  createtime?: number
  updatetime?: number
  title?: string
  shortdesc?: string
  publishtime?: string
  coverimage?: string
  audiofile?: string
  videofile?: string
  briefcontent?: string
  price?: string
  canpointdata?: string
  status?: string
  zxviplevel_ids?: string
  zxviplevelname?: string
  viewcount?: number
  sharecount?: number
  recommend?: string
  hot?: string
  canpointdata_text?: string
  status_text?: string
  recommend_text?: string
  hot_text?: string
}