import notificationManager from '@ohos.notificationManager';
import Prompt from '@system.prompt';
import image from '@ohos.multimedia.image';
import reminderAgent from '@ohos.reminderAgent';

@Entry
@Component
export default struct NotificationPage {
  reminderId: number;

  myReminderAgent() {
    let reminderRequest: reminderAgent.ReminderRequestAlarm = {
      reminderType: reminderAgent.ReminderType.REMINDER_TYPE_ALARM,
      hour: 12,
      minute: 23,
      daysOfWeek: [1, 2, 3, 4, 5, 6, 7], // 星期1~7
      title: '提醒信息 title',
      ringDuration: 10, // 响铃时长
      snoozeTimes: 1, // 延迟提醒次数，默认是0
      timeInterval: 60 * 60 * 5, // 延迟提醒间隔时间
      actionButton: [{
        title: '关闭',
        type: reminderAgent.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
      }]
      /*,
      wantAgent: { // 提醒到达时自动拉起的目标ability
        pkgName: 'com.xiaoxie',
        abilityName: 'MyAbility'
      }*/
    };
    reminderAgent.publishReminder(reminderRequest, (err, reminderId) => {
      if (err) {
        Prompt.showToast({
          message: '发布提醒失败',
          duration: 2000
        })
        return;
      }
      Prompt.showToast({
        message: '发布提醒成功！id = ' + reminderId,
        duration: 2000
      })
      this.reminderId = reminderId;
    })
  }

  publishNotification() {
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 0,
      slotType: notificationManager.SlotType.SERVICE_INFORMATION,
      content: {
        contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: '通知标题',
          text: '这是一个通知的消息内容',
          additionalText: '通知附加内容'  // 附加内容是对通知内容的补充
        }
      }
    };
    notificationManager.publish(notificationRequest).then(() => {
      // 发布通知
      Prompt.showToast({
        message: '发布通知消息成功',
        duration: 2000
      })
    }).catch((err) => {
      Prompt.showToast({
        message: `发布通知失败，失败代码：${err.code},失败原因：${err.message}`,
        duration: 2000
      })
    });
  }

  /* 多行文本通知 */
  publicNotification1() {
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 1,
      content: {
        contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: {
          title: '通知标题',
          text: '通知的内容简介',
          briefText: 'briefText内容',
          longTitle: 'longTitle内容',
          lines: ['第一行内容', '第二行内容', '第三行内容']
        }
      }
    };
    notificationManager.publish(notificationRequest).then(() => {
      // 发布通知
      Prompt.showToast({
        message: '发布通知消息成功',
        duration: 2000
      })
    }).catch((err) => {
      Prompt.showToast({
        message: `发布通知失败，失败代码：${err.code},失败原因：${err.message}`,
        duration: 2000
      })
    });
  }

  /* 图片通知 */
  async publishPictureNotification() {
    // 把资源图片转为PixelMap对象
    let resourceManager = getContext(this).resourceManager;
    let imageArray = await resourceManager.getMediaContent($r('app.media.img').id);
    let imageResource = image.createImageSource(imageArray.buffer);
    let pixelMap = await imageResource.createPixelMap();

    // 描述通知信息
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 2,
      content: {
        contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: '通知消息的标题',
          text: '展开查看详情，通知内容',
          expandedTitle: '展开时的内容标题',
          briefText: '这里是通知的概要内容，对通知的总结',
          picture: pixelMap
        }
      }
    };
    // 发布通知消息
    notificationManager.publish(notificationRequest).then(() => {
      Prompt.showToast({ message: '发布通知消息成功', duration: 2000 })
    }).catch((err) => {
      Prompt.showToast({
        message: `发布通知失败，失败代码：${err.code},失败原因：${err.message}`,
        duration: 2000
      })
    });
  }

  build() {
    Row() {
      Column() {
        Button('发布提醒')
          .width('50%')
          .margin({ bottom: 10 })
          .onClick(() => {
            this.myReminderAgent()
          })
        Button('发送通知')
          .width('50%')
          .margin({ bottom: 10 })
          .onClick(() => {
            this.publishNotification()
          })
        Button('发送多行文本通知')
          .width('50%')
          .margin({ bottom: 10 })
          .onClick(() => {
            this.publicNotification1()
          })
        Button('发送图片通知')
          .width('50%')
          .margin({ bottom: 10 })
          .onClick(() => {
            this.publishPictureNotification()
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}