


--输入命令，测试插件是否工作了
SLASH_NOTE1= "/note";

SlashCmdList['NOTE'] = function ( input )
	if(input and input =='bag') then
		for i=0,4 do
		  local name = GetBagName(i)
		  if name then
		    -- print("Bag", i, ":", name)
		    SendChatMessage("Bag"..i..":"..name,"say")
		  end
		end
	end
	
	-- body
	local hp = UnitHealth('player')
	SendChatMessage("你通过/note命令输入了"..input,"say")

end



--事件。
function HelloWorldEvent()
	-- 说话事件 
   if(event == "CHAT_MSG_SAY") then 
      DEFAULT_CHAT_FRAME:AddMessage(arg2.." said "..arg1); 
   end
   -- 目标改变事件
   if(event == "PLAYER_TARGET_CHANGED") then 
   		
		local targetName  = UnitName("target");
		--判断是否存在目标
		if(targetName) then
      		DEFAULT_CHAT_FRAME:AddMessage("你看着："..targetName);
      	else
      		DEFAULT_CHAT_FRAME:AddMessage("你没有目标："); 
		end
   end

   if ( event == "LOOT_OPENED" ) then
		gLim_HandleLoot();
		return;
	end
	--背包打开事件
	if ( event == "BAG_OPEN" ) then
		gLim_HandleBag(arg1);
		return;
	end



end

--对象
myFrame = getglobal("HelloWorldTestFrame"); 




function HelloWorldCommand(cmd) 
   myFrame = getglobal("HelloWorldTestFrame"); 
   if(not myFrame:IsShown()) then 
      myFrame:Show(); 
   else 
      myFrame:Hide(); 
   end 
end 

function HelloWorldLoad() 
   getglobal("HelloWorldTestFrame"):Hide(); 
   DEFAULT_CHAT_FRAME:AddMessage("HelloWorld is Loaded!"); 
   SLASH_HELLOWORLD1 = "/helloworld"; 
   SLASH_HELLOWORLD2 = "/hw"; 
   SlashCmdList["HELLOWORLD"] = HelloWorldCommand; 
end 

function HelloWorldFrameUpdate() 
   textFPS = getglobal("HelloWorldTestFrameTextFPS"); 
   textDelay = getglobal("HelloWorldTestFrameTextDelay"); 
   textMoney = getglobal("HelloWorldTestFrameTextMoney"); 
   down, up, lag = GetNetStats(); 

   textFPS:SetText("FPS   "..floor(GetFramerate())); 
   textDelay:SetText("Delay   "..lag.." ms"); 
   textMoney:SetText("Money   "..floor(GetMoney()/10000).." G"); 
end
--拾取物品的列表
function gLim_HandleLoot()
	local lootIcon; --图标
	local lootName; --名称
	local lootQuantity; --数量
	local rarity;--罕见度。绿色 蓝色 紫色

	local itemid;
	local enchant;
	local subid;
	local itemname;	
	local itemreadme;
	for index = 1, GetNumLootItems(), 1 do
		if (LootSlotIsItem(index)) then
			lootIcon, lootName, lootQuantity, rarity = GetLootSlotInfo(index);
			DEFAULT_CHAT_FRAME:AddMessage("物品"..index..":"..lootName.."罕见度:"..rarity); 
			
		end
    end
end;
--背包列表
function gLim_HandleBag(bagid)
	-- body
	DEFAULT_CHAT_FRAME:AddMessage("你打开了包裹:"..bagid); 
end
