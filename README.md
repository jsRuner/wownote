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


