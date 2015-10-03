--输入命令，测试插件是否工作了
SLASH_NOTE1= "/note";

SlashCmdList['NOTE'] = function ( input )
	-- body
	local hp = UnitHealth('player')
	SendChatMessage("你通过/note命令输入了"..input,"say")

end

--事件。
function HelloWorldEvent() 
   if(event == "CHAT_MSG_SAY") then 
      DEFAULT_CHAT_FRAME:AddMessage(arg2.." said "..arg1); 
   end 
end

myFrame = getglobal("HelloWorldTestFrame"); 




-- function HelloWorldCommand(cmd) 
--    myFrame = getglobal("HelloWorldTestFrame"); 
--    if(not myFrame:IsShown()) then 
--       myFrame:Show(); 
--    else 
--       myFrame:Hide(); 
--    end 
-- end 

-- function HelloWorldLoad() 
--    getglobal("HelloWorldTestFrame"):Hide(); 
--    DEFAULT_CHAT_FRAME:AddMessage("HelloWorld is Loaded!"); 
--    SLASH_HELLOWORLD1 = "/helloworld"; 
--    SLASH_HELLOWORLD2 = "/hw"; 
--    SlashCmdList["HELLOWORLD"] = HelloWorldCommand; 
-- end 

-- function HelloWorldFrameUpdate() 
--    textFPS = getglobal("HelloWorldTestFrameTextFPS"); 
--    textDelay = getglobal("HelloWorldTestFrameTextDelay"); 
--    textMoney = getglobal("HelloWorldTestFrameTextMoney"); 
--    down, up, lag = GetNetStats(); 

--    textFPS:SetText("FPS   "..floor(GetFramerate())); 
--    textDelay:SetText("Delay   "..lag.." ms"); 
--    textMoney:SetText("Money   "..floor(GetMoney()/10000).." G"); 
-- end