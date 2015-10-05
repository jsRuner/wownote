local t ={}


---------------------------------------------------------------------------------------------------------
--[[初始化]]--
function Wownote_Load()
	--注册事件
	Wownote_Register()
	--添加命令
	Wownote_Slashcmd()


	DEFAULT_CHAT_FRAME:AddMessage("Wownote_Frame is Loaded!");



	 
end

--[[注册事件]]--
function Wownote_Register()
	-- Wownote_Frame = getglobal("WowNoteFrame"); 
	WowNoteFrame:RegisterEvent("CHAT_MSG_SAY");--说话事件
	WowNoteFrame:RegisterEvent("PLAYER_TARGET_CHANGED");--目标切换事件
	WowNoteFrame:RegisterEvent("LOOT_OPEN");--拾取物品事件
	WowNoteFrame:RegisterEvent("BAG_UPDATE");--背包更新 
end

--[[命令列表]]--
function Wownote_Slashcmd()
	-- 显示插件面板
	SLASH_WOWNOTE1 = "/wownote"; 
	SLASH_WOWNOTE2 = "/wn"; 
	--输出数据
	SlashCmdList["WOWNOTE"] = Wownote_Cmd;

end
--[[隐藏或显示面板]]--
function Wownote_Cmd(input)
	 
   	myFrame = getglobal("WowNoteFrame");

   	--显示面板
   	if(input =='' or input =='show') then
	   	Wownote_Display(myFrame,true)
	   	return
   	end
   --隐藏面板
   	if(input =='hidden') then
	   	Wownote_Display(myFrame,false)
	   	return
   	end
   	--打印数据
   	if(input =='showdata') then
   		Wownote_Readdata()
   		return
   	end
   	--保存数据到文件
   	if(input=="export") then
   		Wownote_Savedata2File()
   		return
   	end
   	--获得帮助
   	if(input =='help') then
	   	Wownote_Help()
	   	return
   	end
   	--其他信息
   	DEFAULT_CHAT_FRAME:AddMessage('没有该命令，请输入/wn help 或/wownote help寻求帮助');
   	-- Wownote_Display(myFrame)
end
--[[显示或隐藏面板]]
function Wownote_Display(myFrame,isshow)
	-- body
	if(isshow) then 
		myFrame:Show(); 
	else 
		myFrame:Hide(); 
	end 
end
--[[显示帮助。命令列表]]
function Wownote_Help()
	-- body
	DEFAULT_CHAT_FRAME:AddMessage('命令列表如下');
	DEFAULT_CHAT_FRAME:AddMessage('/wn display or /wownote display 显示或隐藏插件面板');
end


--[[事件关联函数]]--
function Wownote_Event()
-- 说话事件 
   if(event == "CHAT_MSG_SAY") then 
      Wownote_CopySay()
      return
   end
   -- 目标改变事件
   if(event == "PLAYER_TARGET_CHANGED") then 
		Wownote_TipTarget()
		return
   end

   if ( event == "LOOT_OPENED" ) then
		Wownote_HandleLoot();
		return;
	end
end

--[[重复自己说的话]]
function Wownote_CopySay( ... )
	-- body
	 DEFAULT_CHAT_FRAME:AddMessage(arg2.." said "..arg1);
end
--[[提示当前目标]]--
function Wownote_TipTarget( ... )
	-- body
	local targetName  = UnitName("target");
	--判断是否存在目标
	if(targetName) then
  		DEFAULT_CHAT_FRAME:AddMessage("你看着："..targetName);
  		Wownote_Savedata(targetName)

  	else
  		DEFAULT_CHAT_FRAME:AddMessage("你没有目标"); 
	end	
end

--[[状态数据更新]]
function Wownote_Update() 
   textFPS = getglobal("WowNoteFrameTextFPS"); 
   textDelay = getglobal("WowNoteFrameTextDelay"); 
   textMoney = getglobal("WowNoteFrameTextMoney"); 
   down, up, lag = GetNetStats();


  

   textFPS:SetText(date("%Y年%m月%d日:").."FPS   "..floor(GetFramerate())); 
   textDelay:SetText("Delay   "..lag.." ms"); 
   textMoney:SetText("Money   "..floor(GetMoney()/10000).." G"); 
end

--[[拾取物品]]--
function Wownote_HandleLoot()
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

--[[存储数据:内存中]]
function Wownote_Savedata(data)
	-- body
	table.insert(t,data)
end
--[[读取数据]]
function Wownote_Readdata()
	if (table.getn(t) == 0) then
		DEFAULT_CHAT_FRAME:AddMessage("没有数据");
		return 
	end
	for i=1,table.getn(t),1 do
		DEFAULT_CHAT_FRAME:AddMessage("数据"..i.."姓名:"..t[i]);
	end
end
--[[存储数据:文件中]]
function Wownote_Savedata2File()
	-- body
	myFile = io.open("save_data.lua", "w+")
	if myFile ~= nil then
		myFile:write("-- 游戏数据保存文件")
		myFile:write(string.char (10))
		myFile:write(string.char (10))
		myFile:write(string.format("%s%s", "-- 文件创建于: ", date()))
		myFile:write(string.char (10))
		myFile:write(string.char (10))
		myFile:write("myValue = 5")
		io.close(myFile)
	end
end


