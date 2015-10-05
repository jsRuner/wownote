# wownote
魔兽世界记事本
2015年10月3日16:20:15
自动记录练级中发生的一些事情。
形成文本。

需要记录数据包含：每一次升级的时间、拾取到蓝色物品的时间、地点、怪物名称

与其他玩家的聊天记录。

运动的地点轨迹。时间与地区。

存储为指定文件。输入命令时，可以查看记录。

首先需要查询api .地区切换时触发事件。

查询到的事件是

 PLAYER_LEAVING_WORLD

 ACHIEVEMENT_EARNED：玩家获得成就时的事件
 ACTIVE_TALENT_GROUP_CHANGED 切换专业技能或者天赋。
 AUCTION_HOUSE_SHOW  进入拍卖行。测试一次


 ## Interface: 适用的魔兽版本号 
## Title: 显示的标题（默认语言） 
## Notes: 显示的说明（默认语言） 
## Title-zhCN: 特定语言的标题（简体中文） 
## Notes-zhCN: 特定语言的说明（简体中文） 
## Author: 作者（不显示） 
## Version: 版本 
## eMail: 如题 
## UIType: 插件类型 
## Dependencies: 依赖的插件 
## RequiredDeps: 必须依赖的其他插件 
## OptionalDeps: 可选倚赖 
## SavedVariables: 统一存放的变量 
## SavedVariablesPerCharacter: 按角色存放的变量 
## LoadOnDemand: 1 （调用时加载） 
## LoadWith: 当指定插件加载时才加载，前提是调用时加载 
## DefaultState: disabled 默认状态 
## Secure: 安全（功能未知） 
# 注释1 dklasjfkasdj 
Script.lua -- 脚本文件 
% 注释2 dskajfklasdjfklsdaj 
Layout.xml -- 布局文件

知识点：
1、 xml中的frame 可以自己使用名称获取。然后注册事件
2、命令行绑定函数。不能写().否则函数立即执行。
3、格式化日期 date("%Y年%m月%d日:") 魔兽内置了os。不需要使用os.date  来调用。


