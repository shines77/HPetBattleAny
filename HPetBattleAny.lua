-----####HPetBattleAny2.0####
----2.0:petid 不能为0必须为"0x0000000000000000",外加很多对应5.1的修改

local _
--- Globals
local _G = getfenv(0)
local hooksecurefunc, tinsert, pairs, wipe = _G.hooksecurefunc, _G.table.insert, _G.pairs, _G.wipe
local ipairs = _G.ipairs
local C_PetJournal = _G.C_PetJournal
--- --------
local VERSION = GetAddOnMetadata("HPetBattleAny","Version")
local H_PET_BATTLE_CHAT_FRAME={}
local LEVEL_COLLECTED = "(lv:%s)"
local L = HPetLocals


HPetBattleAny = CreateFrame("frame");
HPetBattleAny:SetScript('OnEvent', function(_, event, ...) return HPetBattleAny[event](HPetBattleAny, event, ...) end)

function HPetBattleAny:LoadSomeAny()
	if GetLocale()=="zhCN" then
		PET_BATTLE_COMBAT_LOG_AURA_APPLIED ="%1$s对%3$s %4$s 造成了%2$s效果."
		PET_BATTLE_COMBAT_LOG_PAD_AURA_APPLIED = "%1$s对%3$s 造成了%2$s效果."
	end
	FRAMELOCK_STATES["PETBATTLES"]["Recount_MainWindow"]="hidden"
	FRAMELOCK_STATES["PETBATTLES"]["MinimapCluster"]=""
end

function HPetBattleAny:PlaySoundFile()
------- 这里可以修改声音文件
	PlaySoundFile( [[Sound\Events\scourge_horn.wav]], "Master" );
end
function HPetBattleAny:Loadinginfo()
	self:PetPrintEX(format("HPetBattleAny"..VERSION..L["Loading"],"|cffff0000/hpq|r"))
end
--------------------		SAVE
HPetSaves = {}
function HPetBattleAny:GetDefault()
	return {
		ShowMsg = true,				--在聊天窗口显示信息
		Sound=true,
		ShowGrowInfo=true,			--显示成长值
		PetGreedInfo=false,			--显示品值
		PetBreedInfo=false,			--breeid
		ShowBreedId=false,			--显示breedID
		EnemyAbility=true,			--显示敌对技能
		EnemyAbPoint={},			--位置(nil)
		EnemyAbScale=0.8,			--敌对技能大小
		OnlyInPetInfo=false,
		HighGlow=true,				--战斗中用品质颜色对宠物头像着色
		Tooltip=false,				--额外鼠标提示
	}
end

HPetSaves = HPetBattleAny:GetDefault()

--------------------		载入宠物手册的数据
HPetBattleAny.HasPet={}

--[[		function	]]--
-----	测试函数
function printt(str)
	if HPetSaves.god then
		print(str)
	end
end

function HPetBattleAny.sortRarityLevelAsc(a, b)
	if a.rarity == b.rarity then
		return a.level < b.level
	else
		return a.rarity < b.rarity
	end
end
-----	却确定宠物信息窗口
function HPetBattleAny:GetPetBattleChatFrmae()
	wipe(H_PET_BATTLE_CHAT_FRAME)
	H_PET_BATTLE_CHAT_FRAME={}
	if HPetSaves.OnlyInPetInfo then
		for _, chatFrameName in pairs(CHAT_FRAMES) do
			local frame = _G[chatFrameName];
			for index = #frame.messageTypeList,1,-1 do
				if frame.messageTypeList[index] == "PET_BATTLE_COMBAT_LOG" then
					table.insert(H_PET_BATTLE_CHAT_FRAME,frame)
					break
				end
			end
		end
	end
	if #H_PET_BATTLE_CHAT_FRAME==0 then
		table.insert(H_PET_BATTLE_CHAT_FRAME,DEFAULT_CHAT_FRAME)
	end
end
-----	打印函数
function HPetBattleAny:PetPrintEX(str,...)
	HPetBattleAny:GetPetBattleChatFrmae()

	for _,frame in pairs(H_PET_BATTLE_CHAT_FRAME) do
		if not frame:IsShown() then FCF_StartAlertFlash(frame) end
		frame:AddMessage(str,...)
	end

end
-----	创建宠物链接
function HPetBattleAny.CreateLinkByInfo(petid,petstate,usecustom)
	if petid == 0 or petid == "0x0000000000000000" or not petid then return nil end
	local name,speciesID,customName
	if not petstate then
		petstate={}
		speciesID, customName, petstate.level = C_PetJournal.GetPetInfoByPetID(petid)
		_, petstate.health, petstate.power, petstate.speed, petstate.rarity = C_PetJournal.GetPetStats(petid)
		if not speciesID then return end
		if not usecustom then customName = nil end
	else	--没有唯一ID说明petid就是唯一ID
		speciesID,petid = petid,"0x0000000000000000"
	end

	name = petstate.name or customName or C_PetJournal.GetPetInfoBySpeciesID(speciesID)
	if name then
		local level,health,power,speed,rarity = petstate.level, petstate.health, petstate.power, petstate.speed, petstate.rarity
		if HPetSaves.lie then
			HPetSaves.lie = tonumber(HPetSaves.lie) or 1
			rarity=rarity+HPetSaves.lie
		end
		local bhealth,bpower,bspeed,breedId = HPetDate.GetBreedValue(petstate,speciesID,true)
		health=format("%0.f",bhealth*tonumber("1."..(rarity-1))*level*5+100)
		power=format("%0.f",bpower*tonumber("1."..(rarity-1))*level)
		speed=format("%0.f",bspeed*tonumber("1."..(rarity-1))*level)
		local link=""
		rarity = rarity - 1
		link=ITEM_QUALITY_COLORS[rarity].hex.."\124Hbattlepet:"
		link=link..speciesID..":"..level..":"..rarity..":"..health..":"..power..":"..speed..":"..petid
		link=link.."\124h["..(customName or name).."]\124h\124r"
		return link
	end
	return
end
-----	成长值
function HPetBattleAny.ShowMaxValue(petstate,speciesID,point)
	if not petstate or petstate.rarity<1 then return end
	local breed = tonumber("1."..((petstate and petstate.rarity-1) or 0))

	-- ghealth,gpower,gspeed	------成长值
	-- thealth,tpower,tspeed	------基础值
	-- bhealth,bpower,bspeed	------breed加值


	local bhealth,bpower,bspeed,breedId,thealth,tpower,tspeed = HPetDate.GetBreedValue(petstate,speciesID)

	local ghealth=format("%.1f",(bhealth+thealth)*5*breed)
	local gpower=format("%.1f",(bpower+tpower)*breed)
	local gspeed=format("%.1f",(bspeed+tspeed)*breed)

	-- 输出值
	local rhealth,rpower,rspeed
	rhealth=""
	rpower=""
	rspeed=""

	if point then
		if HPetSaves.PetBreedInfo then
			rhealth = bhealth
			rpower = bpower
			rspeed = bspeed
		elseif HPetSaves.PetGreedInfo then
			rhealth = bhealth+thealth
			rpower = bpower+tpower
			rspeed = bspeed+tspeed
		else
			rhealth = ghealth
			rpower = gpower
			rspeed = gspeed
		end
	else
		local hpsGetInfo=function()
			if HPetSaves.PetGreedInfo and HPetSaves.PetBreedInfo then
				local ty="+"
				return thealth..ty..bhealth,tpower..ty..bpower,tspeed..ty..bspeed
			elseif HPetSaves.PetBreedInfo then
				return bhealth,bpower,bspeed
			elseif HPetSaves.PetGreedInfo then
				return thealth+bhealth,tpower+bpower,tspeed+bspeed
			end
		end
		local stlye1="(|c"..RAID_CLASS_COLORS["ROGUE"].colorStr.."%s|r)"
		local stlye2="(|c"..RAID_CLASS_COLORS["MAGE"].colorStr.."%s|r)"

		if HPetSaves.PetGreedInfo or HPetSaves.PetBreedInfo  then
			rhealth,rpower,rspeed = hpsGetInfo()
			rhealth = format(stlye2,rhealth)
			rpower 	= format(stlye2,rpower)
			rspeed 	= format(stlye2,rspeed)
		end
		if HPetSaves.ShowGrowInfo then
			rhealth = format(stlye1,ghealth)..rhealth
			rpower = format(stlye1,gpower)..rpower
			rspeed = format(stlye1,gspeed)..rspeed
		end

	end
	return rhealth,rpower,rspeed,breedId
end

-----	调出宠物收集信息(已有宠物信息)
function HPetBattleAny:GetPetCollectedInfo(pets,enemypet,islink,mini)
	local str1=""
	local str2=""
	if enemypet and enemypet.level then
		if enemypet.level>20 then
			enemypet.level = enemypet.level-2
		elseif enemypet.level>15 then
			enemypet.level = enemypet.level-1
		end
	end
	if pets then
		table.sort(pets,self.sortRarityLevelAsc)
		if enemypet and self.sortRarityLevelAsc(pets[1],enemypet) then
			str1 = str1.."|cffff0000"..L["Only collected"]	.."：|r"
		else
			str1 = str1.."|cffffff00"..COLLECTED.."：|r"
		end
		for i,petInfo in pairs(pets) do
			local petlink
			local _,custname,_,_,_,_,_,name=C_PetJournal.GetPetInfoByPetID(petInfo.petID)

			if islink then
				petlink=HPetBattleAny.CreateLinkByInfo(petInfo.petID or 0,nil,true)
			end

			if not petlink then
				if (custname or name) and not mini then
					petlink=ITEM_QUALITY_COLORS[petInfo.rarity-1].hex..(custname or name).."|r"
				else
					petlink=ITEM_QUALITY_COLORS[petInfo.rarity-1].hex.._G["BATTLE_PET_BREED_QUALITY"..petInfo.rarity].."|r"

				end
			end

			if petlink then
				if LEVEL_COLLECTED then petlink = format(LEVEL_COLLECTED.."%s",petInfo.level,petlink) end
				if islink or str2=="" then
					str2 = petlink..str2
				else
					str2=petlink.."|n"..str2
				end
			end
		end
	else
		if C_PetBattles.IsPlayerNPC(2) and select(2,C_PetBattles.IsTrapAvailable())>6 and select(2,C_PetBattles.IsTrapAvailable())<9 then
			str1=str1.."|cffffff00".._G["PET_BATTLE_TRAP_ERR_"..select(2,C_PetBattles.IsTrapAvailable())]
		else
			if enemypet and not select(7,C_PetJournal.GetPetInfoBySpeciesID(enemypet.speciesID)) then
				str1=str1.."|cffffff00".._G["PET_BATTLE_TRAP_ERR_6"]
			else
				str1=str1.."|cffff0000"..NOT_COLLECTED.."!|r"
			end
		end
	end
	return str1,str2
end


--[[ 	OnEvent:					PET_BATTLE_OPENING_START	]]--
function HPetBattleAny:PET_BATTLE_OPENING_START()
printt("test:战斗开始")
self.EnemyPetInfo={}
----- 输出敌对宠物的数据
		local petOwner=2
		for petIndex=1, C_PetBattles.GetNumPets(petOwner) do

			local speciesID=C_PetBattles.GetPetSpeciesID(petOwner,petIndex)
			local mPet=HPetBattleAny.HasPet[speciesID]
			local name = C_PetBattles.GetName(petOwner, petIndex);
			local level = C_PetBattles.GetLevel(petOwner, petIndex);
			local health = C_PetBattles.GetMaxHealth(petOwner, petIndex);if C_PetBattles.IsWildBattle() then health =format("%.0f",health * 1.2) end	--生命加20%
			local power = C_PetBattles.GetPower(petOwner, petIndex);
			local speed = C_PetBattles.GetSpeed(petOwner, petIndex);
			local rarity=C_PetBattles.GetBreedQuality(petOwner,petIndex);if rarity>3 and C_PetBattles.IsWildBattle() then self.EnemyPetInfo.FindBlue=true end;
			local isflying = false
			if C_PetBattles.GetAuraInfo(petOwner,petIndex,1) == 239 then
				speed=format("%.0f",speed/1.5) --速度降50%
				isflying = true
			end

			self.EnemyPetInfo[petIndex]={["name"]=name,["level"]=level,["health"]=health,["power"]=power,["speed"]=speed,["rarity"]=rarity,["isflying"]=isflying}

			local breedId=select(4,HPetDate.GetBreedValue(self.EnemyPetInfo[petIndex],speciesID))	--获取breedId

			tmprint=format(L["this is"],petIndex)

			if (breedId and ((breedId>=4 and breedId<=6) or (breedId>=14 and breedId<=16))) then
				tmprint=tmprint..ICON_LIST[ICON_TAG_LIST[strlower(RAID_TARGET_1)]] .. "0|t"
			end

			tmprint=tmprint..HPetBattleAny.CreateLinkByInfo(speciesID,self.EnemyPetInfo[petIndex])

			if LEVEL_COLLECTED then tmprint=format("%s"..LEVEL_COLLECTED,tmprint,level) end

			if HPetSaves.Contrast or true then
				local str1,str2 = HPetBattleAny:GetPetCollectedInfo(mPet,{["level"]=level,["rarity"]=rarity,["speciesID"]=speciesID},true)
				tmprint = tmprint..str1..str2
--~ 				if string.find(str1,"ffff0000") then self.EnemyPetInfo.FindBlue=true end
			end

			if HPetSaves.ShowMsg then
				self:PetPrintEX(tmprint)
			end
		end

		if HPetSaves.Sound and self.EnemyPetInfo.FindBlue then --C_PetBattles.IsPlayerNPC(2) and select(2,C_PetBattles.IsTrapAvailable())~=7 then
--- 		PlaySoundFile( [[Sound\Event Sounds\Event_wardrum_ogre.wav]], "Master" );
			self:PlaySoundFile()
		end

end


--[[	OnEvent:					PET_JOURNAL_LIST_UPDATE		]]--

function HPetBattleAny:PET_JOURNAL_LIST_UPDATE()
	if (HPetSaves.Contrast or true ) and not self.HasPetloading and PetJournal then
--~ 		self:UnregisterEvent("PET_JOURNAL_LIST_UPDATE")
		local Maxnum,numPets = C_PetJournal.GetNumPets(false);
		if not HPetBattleAny.HasPet.num or numPets ~=  HPetBattleAny.HasPet.num or Maxnum > HPetBattleAny.HasPet.Maxnum then
		printt("系统数据:"..numPets.."插件数据"..(self.HasPet.num or 0))
			self:LoadUserPetInfo()
		end
--~ 		self:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
	end
end
function HPetBattleAny:LoadUserPetInfo()
	printt("test:数据处理.进入判断")
	if HPetBattleAny.HasPetloading then
		return	false
	end
	printt("test:数据处理.开始")
	HPetBattleAny.HasPetloading = true
	wipe(HPetBattleAny.HasPet)
	HPetBattleAny.HasPet.truenum= 0
	C_PetJournal.ClearSearchFilter();
	C_PetJournal.AddAllPetTypesFilter();
	C_PetJournal.AddAllPetSourcesFilter();
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true)
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false)

	HPetBattleAny.HasPet.Maxnum ,HPetBattleAny.HasPet.num = C_PetJournal.GetNumPets(false)
	for i=1,select(2,C_PetJournal.GetNumPets(true)) do
		local petID, speciesID, isOwned, _,level= C_PetJournal.GetPetInfoByIndex(i);
		if isOwned then
			if not HPetBattleAny.HasPet[speciesID] then HPetBattleAny.HasPet[speciesID]={} end
			local _,_,_,_,rarity = C_PetJournal.GetPetStats(petID)
			table.insert(HPetBattleAny.HasPet[speciesID],{petID=petID,rarity=rarity,level=level})
			HPetBattleAny.HasPet.truenum=HPetBattleAny.HasPet.truenum+1
		end
	end

	HPetBattleAny.HasPetloading = false
--~ 	if self.HasPet.num~=select(2,C_PetJournal.GetNumPets(true)) then
--~ 		print("您的宠物数据不正确，您的游戏可能未下载完")
--~ 	end
	printt("test:数据处理.结束,载入数据"..HPetBattleAny.HasPet.truenum)
end


--[[	OnEvent:	 				ADDON_LOADED			]]--
function HPetBattleAny:ADDON_LOADED(_, name)
		if name == "HPetBattleAny" and not self.initialized then
			self:UnregisterEvent("ADDON_LOADED")
			self.initialized = true
			printt("test:插件载入")

			self:Loadinginfo()
			self:LoadUserPetInfo()
			self:initforJournalFrame()
			self:LoadSomeAny()
			self.hook:init()

			self:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
end

function HPetBattleAny:PLAYER_ENTERING_WORLD()
	self:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
	self:RegisterEvent("PET_BATTLE_OPENING_START")
end

------------------------我是和谐的分割线---------------------------------


function HPetBattleAny:initforJournalFrame()
	button = CreateFrame("Button","HPetInitOpenButton",PetJournal,"UIPanelButtonTemplate")
	button:SetText(L["HPet Options"])
	button:SetHeight(22)
	button:SetWidth(#L["HPet Options"]*8)
	button:SetPoint("TOPLEFT", PetJournalPetCard, "BOTTOMLEFT", -5, 0)
	button:SetScript("OnClick",function()
		if HPetOption then
			if not HPetOption.ready then HPetOption:Init() end
			if not HPetOption:IsShown() then HPetOption:Open() else HPetOption:Hide() end
		end
	end)

	button = CreateFrame("Button","HPetAllInfoButton",PetJournal,"UIMenuButtonStretchTemplate")
	button:SetText(L["Pet All Info"])
	button:SetHeight(20)
	button:SetWidth(100)
	button:SetPoint("TOPRIGHT", PetJournalPetCard, "BOTTOMRIGHT", -5, 0)
	button.rightArrow:Show()
	button:SetScript("OnClick",function()
		if HPetAllInfoFrame then
			if not HPetAllInfoFrame.ready then HPetAllInfoFrame:Init() end
			if not HPetAllInfoFrame:IsShown() then HPetAllInfoFrame:Open() else HPetAllInfoFrame:Hide() end
		end
	end)

 	PetJournalPetCardModelFrame:SetPoint("TOPLEFT",PetJournalPetCard,75,-21)--65
 	PetJournalPetCardShadows:SetPoint("TOPLEFT",PetJournalPetCard,55,-67)--45
end

HPetBattleAny:RegisterEvent("ADDON_LOADED")
