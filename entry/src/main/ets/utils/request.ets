// 添加请求拦截器
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import promptAction from '@ohos.promptAction';


// axios.defaults.headers.post['Token'] = AppStorage.Get('token')
axios.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么 
  config.headers.Token = AppStorage.Get('token') ?? '599ec5a4-0ac8-48fa-9132-97c6a6188d5b'
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});


// 添加响应拦截器
axios.interceptors.response.use((response: AxiosResponse) => {
  if (response.data.msg) {
    promptAction.showToast({ message: response.data.msg })
  }
  response.data = response.data.data
  // 对响应数据做点什么
  return response;
}, (error: AxiosError) => {
  promptAction.showToast({ message: error.response.data['msg'] })
  // 对响应错误做点什么
  return Promise.reject(error);
});

export { axios }