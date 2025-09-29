import { UserInfo } from "../model/UserInfo"
import { UserProfile } from "./UserProfile"

@Preview
@Component
export struct UserList {
  @State users: UserInfo[] = [
    { id: 1, name: '张三', age: 20, avatar: $r('app.media.img2'), active: true, signature: "这个人很懒，什么都没写" },
    { id: 2, name: '王五', age: 24, avatar: $r('app.media.img'), active: false, signature: "这个人很懒，什么都没写", email: "12345678@qq.com" },
    { id: 3, name: '赵六', age: 20, avatar: $r('app.media.img2'), active: true, signature: "这个人很懒，什么都没写"  },
    { id: 4, name: 'lisi', age: 26, avatar: $r('app.media.img'), active: true, signature: "这个人很懒，什么都没写"  },
    { id: 5, name: 'wangwu', age: 30, avatar: $r('app.media.img2'), active: false, signature: "这个人很懒，什么都没写"  },
    { id: 6, name: 'zhaoliu', age: 28, avatar: $r('app.media.img'), active: true, signature: "这个人很懒，什么都没写" , email: "zhaoliu@example.com" },
    { id: 7, name: 'tianqi', age: 22, avatar: $r('app.media.img2'), active: false, signature: "这个人很懒，什么都没写"  },
    { id: 8, name: 'wangba', age: 35, avatar: $r('app.media.img'), active: true, signature: "这个人很懒，什么都没写"  }
  ]

  build() {
    Column() {
      Text('用户列表')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10, bottom: 15 })

      List({ space: 0 }) {
        ForEach(this.users, (user: UserInfo) => {
          ListItem() {
            UserProfile({ userInfo: user })
              .padding(5)
              .backgroundColor('#ffffff')
              .borderRadius(10)
              .shadow({ radius: 3, color: '#00000010' })
              .margin({ top: 0, bottom: -100 })
          }
        }, (user: UserInfo) => user.id.toString())
      }
      .width('100%')
      .padding({ left: 15, right: 15 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}