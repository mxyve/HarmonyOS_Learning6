import { UserInfo } from "../model/UserInfo"
import pasteboard from '@ohos.pasteboard';
import promptAction from '@ohos.promptAction';

@Preview
@Component
export struct UserProfile {
  @Prop userInfo: UserInfo = {
    id: 1,
    name: '张三',
    age: 20,
    avatar: $r('app.media.img'),
    active: true,
    signature: "123456789"
  }

  aboutToAppear() {
    console.info("userInfo.signature:", this.userInfo.signature)
    console.info("processedSignature in aboutToAppear:", this.getProcessedSignature())

    setTimeout(() => {
      console.info("delayed processedSignature:", this.getProcessedSignature())
    }, 0)
  }

  getProcessedSignature(): string {
    console.info("进入getProcessedSignature方法")
    if (!this.userInfo) {
      console.error("userInfo为空")
      return ''
    }
    if (!this.userInfo.signature) {
      console.info("signature为空")
      return ''
    }
    console.info("处理前的signature:", this.userInfo.signature, "长度:", this.userInfo.signature.length)

    if (this.userInfo.signature.length <= 5) {
      return this.userInfo.signature
    } else {
      const result = this.userInfo.signature.substring(0, 3) + '...'
      console.info("处理后的signature:", result)
      return result
    }
  }

  showFullSignature() {
    if (this.userInfo.signature) {
      const data = pasteboard.createData('text/plain', this.userInfo.signature);
      const controller = pasteboard.getSystemPasteboard();
      controller.setData(data, (err) => {
        if (err) {
          console.error('复制失败：', err);
          promptAction.showToast({ message: '复制失败', duration: 2000 });
        } else {
          promptAction.showToast({ message: '已复制到剪贴板', duration: 2000 });
        }
      });
    } else {
      promptAction.showToast({ message: '该用户没有个性签名', duration: 2000 });
    }
  }

  build() {
    Column() {
      // 卡片容器，添加背景、圆角、阴影
      Column() {
        // 头像和基本信息行
        Row() {
          Image(this.userInfo.avatar)
            .width(80)
            .height(80)
            .borderRadius(40)
            .margin({ right: 15 })
          Column() {
            Text(`姓名：${this.userInfo.name}`)
              .fontSize(28)
              .fontWeight(FontWeight.Medium)
            Text(`年龄：${this.userInfo.age}`)
              .fontSize(26)
              .margin({ top: 5 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 5 })

        // 个性签名行
        Row() {
          Text(`个性签名：${this.getProcessedSignature()}`)
            .fontSize(24)
            .onClick(() => this.showFullSignature())
        }
        .margin({ bottom: 10 })

        // 邮箱行
        if (this.userInfo.email) {
          Text(`邮箱：${this.userInfo.email}`)
            .fontSize(26)
            .margin({ bottom: 10 })
        }

        // 按钮行
        Button(this.userInfo.active ? '禁用用户' : '启用用户')
          .backgroundColor(this.userInfo.active ? '#6b7280' : '#ff4d4f')
          .width(120)
          .height(40)
          .fontSize(16)
          .onClick(() => {
            this.userInfo.active = !this.userInfo.active
          })
      }
      .width('90%')
      .padding(10)
      .backgroundColor('#e6f7ff') // 背景色
      .borderRadius(15) // 圆角
      .shadow({ radius: 5, color: '#cccccc', offsetX: 0, offsetY: 3 }) // 阴影
    }
    .width('100%')
    .height('100%')
  }
}