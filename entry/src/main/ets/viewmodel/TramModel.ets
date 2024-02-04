export class Tram {
  distance: string
  downRunTime: string
  endStation: string
  isFirstEnd: boolean
  lineId: string
  lineName: string
  location: string
  minute: string
  nextArriveTime: string
  orderNum: string
  otherId: string
  startStation: string
  stationId: string
  stationName: string
  status: string
  ticketPrice: number
  twoLine: number
  upRunTime: string
  flag?: boolean //是否是首末班
  dataList?: dataList[]
}

export class dataList {
  minute: string
  nextArriveTime: string
  upRunTime: string
  downRunTime: string
  stationId: string
  stationName: string
  startStation: string
  otherId: string
  endStation: string
  isFirstEnd: boolean
  lineName: string
  lineId: string
  status: string
  ticketPrice: number
  createTime: string
}