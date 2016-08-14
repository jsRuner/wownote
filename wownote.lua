IGAS:NewAddon "WowNote" 

---------------------------------------------- 
-- Logger 
---------------------------------------------- 
Log = System.Logger("WowNote") 
Debug = Log:SetPrefix(1, System.Widget.FontColor.GRAY .. _Name .."[Debug]", true) 
Info = Log:SetPrefix(2, System.Widget.FontColor.HIGHLIGHT .. _Name .."[Info]", true) 
Warn = Log:SetPrefix(3, System.Widget.FontColor.RED .. _Name .."[Warn]", true) 
Log.LogLevel = 1 
Log:AddHandler(print)
Log.TimeFormat = "%X"


date = date or os.date


--间隔时间。获取地区、世界频道、团队成员.10分钟弄个获取一次。
local IntervalTime = 1*10

local LastRun = 0







---------------------------------------------- 
-- Script Handlers 
---------------------------------------------- 
function OnLoad(self) 
   -- Load SavedVariables 
   _DB = self:AddSavedVariable("WowNoteSave")

   -- WowNoteSave={}
   
   -- Load the Log Level 
   if _DB.LogLevel then 
      Log.LogLevel = _DB.LogLevel 
   end 
   -- Slash command 
   self:AddSlashCmd("/wn", "/wownote") 
   -- Register Events 
   -- self:RegisterEvent("CHAT_MSG_CHANNEL")  --频道：世界，综合，本地防务

   self:RegisterEvent("CHAT_MSG_WHISPER_INFORM")  --密语触发。发送时。
   self:RegisterEvent("CHAT_MSG_WHISPER")  --密语触发。接受时。
   
   self:RegisterEvent("ZONE_CHANGED")  --区域变化时。

   self:RegisterEvent("CHAT_MSG_PARTY")  --小队。
   self:RegisterEvent("CHAT_MSG_PARTY_LEADER")  --队长发言事件

   self:RegisterEvent("PLAYER_STOPPED_MOVING")  --用户移动事件




end 

function OnSlashCmd(self, option, info) 
   if not option then return end 
   if option:lower() == "log" and tonumber(info) then 
      info = math.floor(tonumber(info)) 
      if info <= 0 then return end 
      Log.LogLevel = info 
      _DB.LogLevel = info -- keep the log level 
   elseif option:lower() == "start" then 
      _Enabled = true 
   elseif option:lower() == "stop" then 
      _Enabled = false 
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



function CHAT_MSG_WHISPER_INFORM(self,message,receiver,language,channelString,target, ...)
   -- body

   Debug("[私聊]["..date("%X").."]["..receiver.."]:"..message)
   table.insert(WowNoteSave, "[私聊]["..date("%X").."]["..receiver.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(receiver.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end

function CHAT_MSG_WHISPER(self,message,sender,language,channelString,target, ...)
   -- body
   Debug("[私聊]["..date("%X").."][我]:"..message)
   table.insert(WowNoteSave, "[私聊]["..date("%X").."][我]:"..message)
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
   Debug("[小队]["..date("%X").."]["..sender.."]:"..message)
   table.insert(WowNoteSave, "[小队]["..date("%X").."]["..sender.."]:"..message)
   -- DEFAULT_CHAT_FRAME:AddMessage(sender.." said "..message)
   -- DEFAULT_CHAT_FRAME:AddMessage("language="..language.." channelString ="..channelString.." target="..target)
end



-- function ZONE_CHANGED(self)
function PLAYER_STOPPED_MOVING(self)
   -- body
   --比较下时间。如果时间超过10分钟。则记录一次。
   Debug('%s',time())
   Debug('%s',LastRun)
   if (time() - LastRun < IntervalTime) then
      Debug('间隔时间低于10分钟')
      return 
   end

   LastRun = time()


   local zoneText = GetMinimapZoneText()
   table.insert(WowNoteSave, "[位置]["..date("%X").."]:"..zoneText)
   Debug("[位置]["..date("%X").."]:"..zoneText)

   if ( IsInRaid()  ) then
      kind = "RAID";
   elseif ( IsInGroup()  ) then
      kind = "PARTY";
   else
      kind = 'SOLO'
   end

   raidNames=''
   partyNames=''

   local nRaid = GetNumGroupMembers();
   local nParty = GetNumSubgroupMembers();

   if ( kind ) then
      if ( kind == "RAID" ) then
         start = 1;
         stop = nRaid;
         for i=start,stop,1
         do 
            raidNames = raidNames..GetRaidRosterInfo(i)..','
         end

         table.insert(WowNoteSave, "[团队]"..nRaid.."名单:"..raidNames)
         Debug("[团队]"..nRaid.."名单:"..raidNames)
      else
         if ( kind == "SOLO"  ) then
            start = 0;
         else
            start = 1;
         end
         stop = nParty;

         x = GetHomePartyInfo()
         if(x) then
            for i=start,stop,1
            do 
               partyNames = partyNames..x[i]..','
            end
            table.insert(WowNoteSave, "[小队]"..nParty.."名单:"..partyNames)
            Debug("[小队]"..nParty.."名单:"..partyNames)
         else
            Debug("[个人]only you!")

         end
        
      end
   end
end







