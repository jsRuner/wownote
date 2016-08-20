t =IGAS:NewAddon "WowNote" 
---------------------------------------------- 
-- Logger 
---------------------------------------------- 
Log = System.Logger("WowNote") 
Debug = Log:SetPrefix(1, System.Widget.FontColor.GRAY .. _Name .."[Debug]", true) 
Info = Log:SetPrefix(2, System.Widget.FontColor.HIGHLIGHT .. _Name .."[Info]", true) 
Warn = Log:SetPrefix(3, System.Widget.FontColor.RED .. _Name .."[Warn]", true) 
Log.LogLevel = 2

Log:AddHandler(print)
Log.TimeFormat = "%X"
---------------------------------------------- 
-- 一些预定义参数 
---------------------------------------------- 
date = date or os.date
--间隔时间。获取地区、世界频道、团队成员.10分钟获取一次。
local IntervalTime = 10*60
local LastRun = 0

import "System.Widget"
f = Form("WowNoteForm")
f.Caption = "魔兽笔记设置"
f:SetWidth(500)
f.Resizable = false

---------------------------------------------- 
-- Script Handlers 
---------------------------------------------- 
function OnLoad(self) 
   print("|cff00e0e0***********************...|r")
   print("|cff00e0e0魔兽笔记开始载入...|r")
   print("|cff00e0e0***********************...|r")

   print("|cffa3d900【魔兽笔记温馨提示】:请从NGA下载插件，其他地方无法保证安全,如果有异常，请联系QQ 540045865...|r")

   -- Load SavedVariables 
   _DB = self:AddSavedVariable("WowNoteSave")
   _DB = self:AddSavedVariable("WowNoteConfig")
   -- Load the Log Level 
   -- if _DB.LogLevel then 
   --    Log.LogLevel = _DB.LogLevel 
   -- end


   ---------------------------------------------- 
   -- UI
   ---------------------------------------------- 
  


   --信息过滤
   chk = CheckBox("Chk", f)
   chk:SetPoint("TOPLEFT", 4, -26)
   chk.Text = "世界频道"
   function chk:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_CHANNEL")  
         Debug('注册世界频道事件')
         WowNoteConfig['CHAT_MSG_CHANNEL'] = true
      else
         t:UnregisterEvent("CHAT_MSG_CHANNEL")
         Debug('取消注册世界频道事件')
         WowNoteConfig['CHAT_MSG_CHANNEL'] = false
      end
   end

   --CHAT_MSG_ACHIEVEMENT 获得成就事件。
   chk_1 = CheckBox("Chk_1", f)
   chk_1:SetPoint("TOPLEFT", 100, -26)
   chk_1.Text = "成就"

   -- chk_1:SetChecked(true)


   function chk_1:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_ACHIEVEMENT")  
         Debug('注册成就事件')
         WowNoteConfig['CHAT_MSG_ACHIEVEMENT'] = true
      else
         t:UnregisterEvent("CHAT_MSG_ACHIEVEMENT")
         Debug('取消成就事件')
         WowNoteConfig['CHAT_MSG_ACHIEVEMENT'] = false
      end
   end

   --
   chk_2 = CheckBox("Chk_2", f)
   chk_2:SetPoint("TOPLEFT", 200, -26)
   chk_2.Text = "发出私聊"
   function chk_2:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_WHISPER_INFORM")  
         Debug('注册私聊【发出】事件')
         WowNoteConfig['CHAT_MSG_WHISPER_INFORM'] = true
      else
         t:UnregisterEvent("CHAT_MSG_WHISPER_INFORM")
         Debug('取消私聊【发出】事件')
         WowNoteConfig['CHAT_MSG_WHISPER_INFORM'] = false
      end
   end


   --
   chk_3 = CheckBox("Chk_3", f)
   chk_3:SetPoint("TOPLEFT", 300, -26)
   chk_3.Text = "收到私聊"
   function chk_3:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_WHISPER")  
         Debug('注册私聊【收到】事件')
          WowNoteConfig['CHAT_MSG_WHISPER'] = true
      else
         t:UnregisterEvent("CHAT_MSG_WHISPER")
         Debug('取消私聊【收到】事件')
         WowNoteConfig['CHAT_MSG_WHISPER'] = false
      end
   end

   --
   chk_4 = CheckBox("Chk_4", f)
   chk_4:SetPoint("TOPLEFT", 400, -26)
   chk_4.Text = "区域变化"
   function chk_4:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("ZONE_CHANGED")  
         Debug('注册区域变化事件')
          WowNoteConfig['ZONE_CHANGED'] = true
      else
         t:UnregisterEvent("ZONE_CHANGED")
         Debug('取消区域变化事件')
          WowNoteConfig['ZONE_CHANGED'] = false
      end
   end

   chk_5 = CheckBox("Chk_5", f)
   chk_5:SetPoint("TOPLEFT", 4, -52)
   chk_5.Text = "小队"
   function chk_5:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_PARTY")  
         Debug('注册小队发言事件')
         WowNoteConfig['CHAT_MSG_PARTY'] = true

      else
         t:UnregisterEvent("CHAT_MSG_PARTY")
         Debug('取消小队发言事件')
         WowNoteConfig['CHAT_MSG_PARTY'] = false
      end
   end

   chk_6 = CheckBox("Chk_6", f)
   chk_6:SetPoint("TOPLEFT", 100, -52)
   chk_6.Text = "小队队长"
   function chk_6:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_PARTY_LEADER")  
         Debug('注册队长发言事件')
         WowNoteConfig['CHAT_MSG_PARTY_LEADER'] = true
      else
         t:UnregisterEvent("CHAT_MSG_PARTY_LEADER")
         Debug('取消队长发言事件')
         WowNoteConfig['CHAT_MSG_PARTY_LEADER'] = false
      end
   end


   chk_7 = CheckBox("Chk_7", f)
   chk_7:SetPoint("TOPLEFT", 200, -52)
   chk_7.Text = "说话"
   function chk_7:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_SAY")  
         Debug('注册说话事件')
         WowNoteConfig['CHAT_MSG_SAY'] = true
      else
         t:UnregisterEvent("CHAT_MSG_SAY")
         Debug('取消说话事件')
         WowNoteConfig['CHAT_MSG_SAY'] = false
      end
   end


   chk_8 = CheckBox("Chk_8", f)
   chk_8:SetPoint("TOPLEFT", 300, -52)
   chk_8.Text = "大声喊"
   function chk_8:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_YELL")  
         Debug('注册大声喊事件')
         WowNoteConfig['CHAT_MSG_YELL'] = true
      else
         t:UnregisterEvent("CHAT_MSG_YELL")
         Debug('取消大声喊事件')
         WowNoteConfig['CHAT_MSG_YELL'] = false
      end
   end

   chk_9 = CheckBox("Chk_9", f)
   chk_9:SetPoint("TOPLEFT", 400, -52)
   chk_9.Text = "副本"
   function chk_9:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")  
         Debug('注册副本事件')
         WowNoteConfig['CHAT_MSG_INSTANCE_CHAT'] = true
      else
         t:UnregisterEvent("CHAT_MSG_INSTANCE_CHAT")
         Debug('取消副本事件')
         WowNoteConfig['CHAT_MSG_INSTANCE_CHAT'] = false
      end
   end


   chk_10 = CheckBox("Chk_10", f)
   chk_10:SetPoint("TOPLEFT", 4, -78)
   chk_10.Text = "副本队长"
   function chk_10:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")  
         Debug('注册副本队长事件')
         WowNoteConfig['CHAT_MSG_INSTANCE_CHAT_LEADER'] = true
      else
         t:UnregisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")
         Debug('取消副本队长事件')
         WowNoteConfig['CHAT_MSG_INSTANCE_CHAT_LEADER'] = false
      end
   end

   chk_11 = CheckBox("Chk_11", f)
   chk_11:SetPoint("TOPLEFT", 100, -78)
   chk_11.Text = "RAID"
   function chk_11:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_RAID")  
         Debug('注册RAID事件')
         WowNoteConfig['CHAT_MSG_RAID'] = true
      else
         t:UnregisterEvent("CHAT_MSG_RAID")
         Debug('取消RAID事件')
         WowNoteConfig['CHAT_MSG_RAID'] = false
      end
   end

   chk_12 = CheckBox("Chk_12", f)
   chk_12:SetPoint("TOPLEFT", 200, -78)
   chk_12.Text = "RAID队长"
   function chk_12:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_RAID_LEADER")  
         Debug('注册RAID队长事件')
         WowNoteConfig['CHAT_MSG_RAID_LEADER'] = true
      else
         t:UnregisterEvent("CHAT_MSG_RAID_LEADER")
         Debug('取消RAID队长事件')
         WowNoteConfig['CHAT_MSG_RAID_LEADER'] = false
      end
   end

   chk_13 = CheckBox("Chk_13", f)
   chk_13:SetPoint("TOPLEFT", 300, -78)
   chk_13.Text = "表情消息"
   function chk_13:OnValueChanged()
      if self.Checked then
         t:RegisterEvent("CHAT_MSG_TEXT_EMOTE")  
         Debug('注册表情消息事件')
         WowNoteConfig['CHAT_MSG_TEXT_EMOTE'] = true
      else
         t:UnregisterEvent("CHAT_MSG_TEXT_EMOTE")
         Debug('取消表情消息事件')
         WowNoteConfig['CHAT_MSG_TEXT_EMOTE'] = false
      end
   end

   --底部关于
   about = FontString('about',f)
   about:SetPoint("BOTTOMLEFT", 4, 20)
   -- about:SetNonSpaceWrap(true)
   about.JustifyH = "CENTER"
   about:SetWidth(500)
   about.Text = "\r有什么问题可以NGA反馈。作者:北岸的云。请联系QQ 540045865 \r本插件K大教程制作。特此感谢"





   icon = MinimapIcon("MapIcon", f)
   icon:SetIcon("Interface\\AddOns\\\WowNote\\logo.tga")
   icon.Tooltip = '魔兽笔记'



   function icon:OnClick()
      if f:IsShown()  then
         f:Hide()
      else
         f:Show()
      end
   end


   --读取配置，初始化按钮。
   if WowNoteConfig then
      chat_config = WowNoteConfig

      --第一次展示。则显示。否则不显示
      if chat_config['CLOSE_FORM'] then
         f:Hide()
      else
         f:Show()
         WowNoteConfig['CLOSE_FORM'] = true
      end


      if chat_config['CHAT_MSG_CHANNEL'] then
         chk:SetChecked(true)
         t:RegisterEvent("CHAT_MSG_CHANNEL")  
      end

      if chat_config['CHAT_MSG_ACHIEVEMENT'] then
         chk_1:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_ACHIEVEMENT")  
      end

      if chat_config['CHAT_MSG_WHISPER_INFORM'] then
         chk_2:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_WHISPER_INFORM")  
      end

      if chat_config['CHAT_MSG_WHISPER'] then
         chk_3:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_WHISPER")  
      end

      if chat_config['ZONE_CHANGED'] then
         chk_4:SetChecked(true)
          t:RegisterEvent("ZONE_CHANGED")  
      end

      if chat_config['CHAT_MSG_PARTY'] then
         chk_5:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_PARTY")  
      end

      if chat_config['CHAT_MSG_YELL'] then
         chk_6:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_YELL")  
      end

      if chat_config['CHAT_MSG_SAY'] then
         chk_7:SetChecked(true)
         t:RegisterEvent("CHAT_MSG_SAY") 

      end

      if chat_config['CHAT_MSG_YELL'] then
         chk_8:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_YELL")  
      end

      if chat_config['CHAT_MSG_INSTANCE_CHAT'] then
         chk_9:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")  
      end

      if chat_config['CHAT_MSG_INSTANCE_CHAT_LEADER'] then
         chk_10:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER")  
      end

      if chat_config['CHAT_MSG_RAID'] then
         chk_11:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_RAID")  
      end

      if chat_config['CHAT_MSG_RAID_LEADER'] then
         chk_12:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_RAID_LEADER")  
      end

      if chat_config['CHAT_MSG_TEXT_EMOTE'] then
         chk_13:SetChecked(true)
          t:RegisterEvent("CHAT_MSG_TEXT_EMOTE")  
      end
   end


   -- Slash command 
   self:AddSlashCmd("/wn", "/wownote") 
   -- Register Events 

   print("|cff00e0e0插件载入完毕...|r")


   

end 



function OnSlashCmd(self, option, info) 
   if not option then return end 
   if option:lower() == "log" and tonumber(info) then 
      info = math.floor(tonumber(info)) 
      if info <= 0 then return end 
      Log.LogLevel = info 
      -- _DB.LogLevel = info -- keep the log level 
   elseif option:lower() == "start" then 
      _Enabled = true

   elseif option:lower() == "stop" then 
      _Enabled = false
   elseif option:lower() == 'show' then
      f:Show() 
   end 
end 

function OnEnable(self) 
   Debug("%s is Enabled!!", _Name) 
end 

function OnDisable(self) 
   Debug("%s is Disabled!!", _Name) 
end 

---------------------------------------------- 
-- Events 
---------------------------------------------- 

--综合 防务 世界
function CHAT_MSG_CHANNEL(self,message,receiver,language,channelString,target, ...)
   -- body
   -- print(1);
   Debug("[世界频道]["..date("%X").."]["..receiver.."]:"..message)
   table.insert(WowNoteSave, "[世界频道]["..date("%X").."]["..receiver.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(receiver.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

--成就
function CHAT_MSG_ACHIEVEMENT(self,message,receiver,language,channelString,target, ...)
   -- body
   Debug("[成就]["..date("%X").."]["..receiver.."]:"..message)
   table.insert(WowNoteSave, "[成就]["..date("%X").."]["..receiver.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(receiver.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end


--收到私聊
function CHAT_MSG_WHISPER_INFORM(self,message,receiver,language,channelString,target, ...)
   -- body

   Debug("[收到私聊]["..date("%X").."]["..receiver.."]:"..message)
   table.insert(WowNoteSave, "[收到私聊]["..date("%X").."]["..receiver.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(receiver.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

--发出私聊
function CHAT_MSG_WHISPER(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[私聊]["..date("%X").."][我]:"..message)
   table.insert(WowNoteSave, "[私聊]["..date("%X").."][我]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

--区域变化
function ZONE_CHANGED(self,...)
   -- body
   local zoneText = GetMinimapZoneText()
   Debug("[区域变化]["..date("%X").."][我]:"..zoneText)
   table.insert(WowNoteSave, "[区域变化]["..date("%X").."][我]:"..zoneText)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end




function CHAT_MSG_PARTY(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[小队]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[小队]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

function CHAT_MSG_PARTY_LEADER(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[小队队长]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[小队队长]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

function CHAT_MSG_SAY(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[说话]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[说话]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end


function CHAT_MSG_YELL(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[喊话]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[喊话]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end


function CHAT_MSG_INSTANCE_CHAT(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[副本]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[副本]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

function CHAT_MSG_INSTANCE_CHAT_LEADER(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[副本向导]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[副本向导]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

function CHAT_MSG_RAID(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[RADI]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[RAID]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

function CHAT_MSG_RAID_LEADER(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[RAID队长]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[RAID队长]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end



function CHAT_MSG_TEXT_EMOTE(self,message,receiver,language,channelString,target, ...)
   -- body
   Debug("[表情]["..date("%X").."]["..receiver.."]:"..message)
   table.insert(WowNoteSave, "[表情]["..date("%X").."]["..receiver.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(receiver.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end



-- -- function ZONE_CHANGED(self)
-- function PLAYER_STOPPED_MOVING(self)
--    -- body
--    --比较下时间。如果时间超过10分钟。则记录一次。
--    Debug('%s',time())
--    Debug('%s',LastRun)
--    if (time() - LastRun < IntervalTime) then
--       Debug('间隔时间低于10分钟')
--       return 
--    end

--    LastRun = time()


--    local zoneText = GetMinimapZoneText()
--    table.insert(WowNoteSave, "[位置]["..date("%X").."]:"..zoneText)
--    Debug("[位置]["..date("%X").."]:"..zoneText)

--    if ( IsInRaid()  ) then
--       kind = "RAID";
--    elseif ( IsInGroup()  ) then
--       kind = "PARTY";
--    else
--       kind = 'SOLO'
--    end

--    raidNames=''
--    partyNames=''

--    local nRaid = GetNumGroupMembers();
--    local nParty = GetNumSubgroupMembers();

--    if ( kind ) then
--       if ( kind == "RAID" ) then
--          start = 1;
--          stop = nRaid;
--          for i=start,stop,1
--          do 
--             raidNames = raidNames..GetRaidRosterInfo(i)..','
--          end

--          table.insert(WowNoteSave, "[团队]"..nRaid.."名单:"..raidNames)
--          Debug("[团队]"..nRaid.."名单:"..raidNames)
--       else
--          if ( kind == "SOLO"  ) then
--             start = 0;
--          else
--             start = 1;
--          end
--          stop = nParty;

--          x = GetHomePartyInfo()
--          if(x) then
--             for i=start,stop,1
--             do 
--                partyNames = partyNames..x[i]..','
--             end
--             table.insert(WowNoteSave, "[小队]"..nParty.."名单:"..partyNames)
--             Debug("[小队]"..nParty.."名单:"..partyNames)
--          else
--             Debug("[个人] 孤独寂寞的一个人")

--          end
        
--       end
--    end
-- end







