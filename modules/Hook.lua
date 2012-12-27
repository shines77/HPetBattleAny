-----####Hook.lua 2.4####
-------2.4:某些地方用了SetScript，全部改成HookScript
local _
----- Globals
local _G = getfenv(0)
local hooksecurefunc, tinsert, pairs, wipe = _G.hooksecurefunc, _G.table.insert, _G.pairs, _G.wipe
local ipairs = _G.ipairs
local C_PetJournal = _G.C_PetJournal
----- --------
local L = HPetLocals
local hookfunction = CreateFrame("frame")
HPetBattleAny.hook = hookfunction


--[[	function]]--
local function TooltipAddOtherInfo(speciesID)
	if HPetSaves.Tooltip then
		local sourceText = select(5,C_PetJournal.GetPetInfoBySpeciesID(speciesID))
		if sourceText and sourceText~="" then
			if HPetBattleAny.HasPet[speciesID] then
				local str1,str2 = HPetBattleAny:GetPetCollectedInfo(HPetBattleAny.HasPet[speciesID])
				GameTooltip:AddDoubleLine(str2,nil, 1, 1, 1);
			end
			GameTooltip:AddLine(sourceText, 1, 1, 1, true);
			GameTooltip:Show();
		end
	end
end

local function IDtoString(id)
	if id and type(id)~="string" then
		id = format("%x",id)
		id = "0x"..string.rep("0",16-#id)..id
		printt("宠物ID异常")
	end
	return id
end
--[[	init	]]--
hookfunction.init = function()
	for a,b in pairs(HPetBattleAny.hook) do
		if a=="PetBattleUnitFrame_OnClick" then
			--------------------------点击头像
			PetBattleFrame.ActiveAlly:HookScript("OnClick",b)
			PetBattleFrame.ActiveEnemy:HookScript("OnClick",b)
			PetBattleFrame.Ally2:HookScript("OnClick",b)
			PetBattleFrame.Ally3:HookScript("OnClick",b)
			PetBattleFrame.Enemy2:HookScript("OnClick",b)
			PetBattleFrame.Enemy3:HookScript("OnClick",b)
		elseif a=="PetBattleFrame_ButtonUp" or a=="PetBattleFrame_ButtonDown" then
			local temp=_G[a]
			_G[a]=function(id)
				b(id,temp)
			end
		elseif a=="PetJournalUtil_GetDisplayName" or a=="FloatingBattlePet_Toggle" then
			_G[a]=b
		elseif a~=0 and a~="init" then
			hooksecurefunc(a,b)
		end
		PetJournal.listScroll.update = PetJournal_UpdatePetList;
	end

	PetBattlePrimaryUnitTooltip:HookScript("OnHide",function() GameTooltip:Hide() end)
--~ 鼠标提示加入简单的收集信息
	GameTooltip:HookScript("OnTooltipSetUnit",function()
		local unit = select(2,GameTooltip:GetUnit())
		if unit and UnitIsBattlePet and UnitIsBattlePet(unit) then
			local speciesID = UnitBattlePetSpeciesID(select(2,GameTooltip:GetUnit()))
			local str = C_PetJournal.GetOwnedBattlePetString(speciesID)
			if not UnitIsWildBattlePet(unit) then GameTooltip:AddLine(str) end
			TooltipAddOtherInfo(speciesID)
		end
	end)

	PetBattleFrame.BottomFrame.ForfeitButton:SetID(6)
	--------------hook宠物api
	C_PetJournal.GetOwnedBattlePetStringtemp=C_PetJournal.GetOwnedBattlePetString
	C_PetJournal.GetOwnedBattlePetString=function(id)
		local str = C_PetJournal.GetOwnedBattlePetStringtemp(id)
		if not str then
			return GREEN_FONT_COLOR_CODE..format(ITEM_PET_KNOWN, C_PetJournal.GetNumCollectedInfo(id))..FONT_COLOR_CODE_CLOSE
		else
			return str
		end
	end
	-----------------
	if HPetBattleAny.CreateLinkByInfo then
		C_PetJournal.GetBattlePetLink=function(id)
			return HPetBattleAny.CreateLinkByInfo(id)
		end
		HP_L=function(id,mlevel,mhealth,mpower,mspeed,mrarity)
			if mlevel==nil then
				print(C_PetJournal.GetPetInfoBySpeciesID(id))
				mlevel=1;mhealth=3;mpower=1
			end
			if mrarity~=nil then
				local data={level=mlevel,health=mhealth,power=mpower,speed=mspeed,rarity=mrarity}
				print(HPetBattleAny.CreateLinkByInfo(id,data))
			elseif HPetDate[id] then	----id/level/breedid/rarity
				local rarity=mpower
				local health,power,speed=HPetDate.GetBreedByID(mhealth)
				health = format("%0.f",(health+HPetDate[id][1])*mlevel*tonumber("1."..mpower-1)*5+100)
				power = format("%0.f",(power+HPetDate[id][2])*mlevel*tonumber("1."..mpower-1))
				speed = format("%0.f",(speed+HPetDate[id][3])*mlevel*tonumber("1."..mpower-1))
				print(health,power,speed)
				local data={level=mlevel,health=health,power=power,speed=speed,rarity=rarity}
				print(HPetBattleAny.CreateLinkByInfo(id,data))
			end
		end
	end

------	点击链接无法正确指向宠物(修复处1)
	C_PetJournal.GetPetInfoByPetIDtemp=C_PetJournal.GetPetInfoByPetID
	C_PetJournal.GetPetInfoByPetID=function(id)
		return C_PetJournal.GetPetInfoByPetIDtemp(IDtoString(id))
	end
	C_PetJournal.GetPetStatstemp=C_PetJournal.GetPetStats
	C_PetJournal.GetPetStats=function(id)
		return C_PetJournal.GetPetStatstemp(IDtoString(id))
	end
	-----------------
end
--[[			]]--其他界面隐藏/显示
hookfunction.AddFrameLock=function(lock)
	if lock == "PETBATTLES" then
		for k,s in pairs(HPetBattleAny.AUtoHideShowfrmae) do
			local v = _G[k]
			if v then
				if type(v["originalShow"]) == "function" then
					v:originalShow()
				elseif type(v["Show"]) == "function" then
					HPetBattleAny.AUtoHideShowfrmae[k]=v:IsShown() and "Shown" or "Hidden"
					if HPetBattleAny.AUtoHideShowfrmae[k]=="Shown" then v:Hide() end
				end
			end
		end
	end
end
hookfunction.RemoveFrameLock=function(lock)
	if lock == "PETBATTLES" then
		for k,s in pairs(HPetBattleAny.AUtoHideShowfrmae) do
			local v = _G[k]
			if v then
				if type(v["originalShow"]) ~= "function" and type(v["Show"]) == "function" then
					if HPetBattleAny.AUtoHideShowfrmae[k]=="Shown" then v:Show() end
				end
			end
		end
	end
end


--[[	Hook	]]--petjournal
------	点击链接无法正确指向宠物(修复处2)
hookfunction.PetJournal_SelectPet = function(self, targetPetID)
	local numPets = C_PetJournal.GetNumPets(PetJournal.isWild);
	local petIndex = nil;
	for i = 1,numPets do
		local petID, speciesID, owned = C_PetJournal.GetPetInfoByIndex(i, PetJournal.isWild);
		if (petID == IDtoString(targetPetID)) then
			petIndex = i;
			break;
		end
	end
	if ( petIndex ) then
		PetJournalPetList_UpdateScrollPos(self.listScroll, petIndex);
	end
	PetJournal_ShowPetCardByID(IDtoString(targetPetID));
end
----------删除宠物，提醒消息中附带宠物颜色(貌似会导致删除宠物不可用)
hookfunction.PetJournalUtil_GetDisplayName=function(petID)
	local speciesID, customName, level, xp, maxXp, displayID, isFavorite, petName, petIcon, petType, creatureID = C_PetJournal.GetPetInfoByPetID(petID);
	local rarity = select(5,C_PetJournal.GetPetStats(petID))
	if ( customName ) then
		return ITEM_QUALITY_COLORS[rarity-1].hex..customName.."\r";
	else
		return ITEM_QUALITY_COLORS[rarity-1].hex..petName.."\r";
	end
end
----- 显示宠物/记录breedid (对没有标示品质的宠物进行标示品质)--5.1已有
hookfunction.PetJournal_UpdatePetCard=function(self)
	local strbreedID=""
	if PetJournalPetCard.petID then
		local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable = C_PetJournal.GetPetInfoByPetID(PetJournalPetCard.petID)
		local _,health,power,speed,rarity = C_PetJournal.GetPetStats(PetJournalPetCard.petID)
		local petstate={["level"]=level,["health"]=health,["power"]=power,["speed"]=speed,["rarity"]=rarity}
		if speciesID then
			local ghealth, gpower, gspeed, breedID= HPetBattleAny.ShowMaxValue(petstate,speciesID)
			self.HealthFrame.health:SetText(format("%d%s",health,ghealth))
			self.PowerFrame.power:SetText(format("%d%s",power,gpower))
			self.SpeedFrame.speed:SetText(format("%d%s",speed,gspeed))
			if breedID and HPetSaves.ShowBreedID then
				strbreedID = "("..(breedID <=12 and breedID or (breedID-10)).."/"..(breedID<=12 and (breedID+10) or breedID)..")"
			end
			PetJournalPetCard.breedID=breedID
		end
	else
		PetJournalPetCard.breedID=nil
	end
	if PetJournalPetCard.speciesID then
		local petType=select(3,C_PetJournal.GetPetInfoBySpeciesID(PetJournalPetCard.speciesID))
		PetJournalPetCard.TypeInfo.type:SetText(_G["BATTLE_PET_NAME_"..petType].."("..PetJournalPetCard.speciesID..")"..strbreedID)
	end

	-------------------显示选择好的技能组合
	if PetJournalPetCard.speciesID and HPetSaves.AutoSaveAbility and HPetSaves["PetAblitys"] then
		local str = HPetSaves.PetAblitys[PetJournalPetCard.petID] or "123"
		local abilities = {}
		C_PetJournal.GetPetAbilityList(PetJournalPetCard.speciesID, abilities)
		for i = 1,3 do
			local d = tonumber(string.sub(str,i,i))
			if d == 0 then d = i end
				_G["PetJournalPetCardSpell"..d].icon:SetVertexColor(1,1,1,1)
				if _G["PetJournalPetCardSpell"..((d>3) and (d-3) or (d+3))].LevelRequirement:IsShown() then
					_G["PetJournalPetCardSpell"..((d>3) and (d-3) or (d+3))].icon:SetVertexColor(1,1,1,1)
				else
					_G["PetJournalPetCardSpell"..((d>3) and (d-3) or (d+3))].icon:SetVertexColor(0.4,0.4,0.4,1)
				end
		end
	end
end
--[[	Hook	]]--petbattle
--------------------		鼠标提示/头像
hookfunction.PetBattleUnitTooltip_UpdateForUnit = function(self, petOwner, petIndex)
	local r,g,b,hex=GetItemQualityColor(C_PetBattles.GetBreedQuality(petOwner,petIndex)-1)
	local speciesID=C_PetBattles.GetPetSpeciesID(petOwner,petIndex)
	local name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
	local strbreedID=""
------- 成长值
	GameTooltip:SetOwner(self,"ANCHOR_BOTTOM");
	if petOwner == LE_BATTLE_PET_ENEMY and HPetBattleAny.EnemyPetInfo[petIndex] then
		local EnemyPet=HPetBattleAny.EnemyPetInfo[petIndex]
		local ghealth, gpower, gspeed, breedID = HPetBattleAny.ShowMaxValue(EnemyPet,speciesID,true)
		if ghealth~="" and ghealth~=nil then
			local str=""
			if HPetSaves.PetBreedInfo then
				str=L["Breed Point"]
			elseif HPetSaves.PetGreedInfo then
				str=L["Greed Point"]
			else
				str=L["Grow Point"]
			end
			GameTooltip:AddDoubleLine(str,"|c"..hex..ghealth.."/"..gpower.."/"..gspeed.."|r")
			GameTooltip:Show();
		end
	end

-----	加入收集信息
	TooltipAddOtherInfo(speciesID)

----- 	技能CD
	if true then
		self.AbilitiesLabel:Show();
		local enemyPetType = C_PetBattles.GetPetType(PetBattleUtil_GetOtherPlayer(petOwner), C_PetBattles.GetActivePet(PetBattleUtil_GetOtherPlayer(petOwner)));
		for i = 1, NUM_BATTLE_PET_ABILITIES do
			local id, name, icon, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(petOwner, petIndex, i);

			local abilityIcon = self["AbilityIcon"..i];
			local abilityName = self["AbilityName"..i];
			if id then
				local CanUse, abilityCD = C_PetBattles.GetAbilityState(petOwner,petIndex,i)
				if CanUse then
					name = "|cffffff00"..name.."|r"
				else
					name = "|cffff0000"..name.."|r"
				end

				if abilityCD~=0 then
					name = name.." "..abilityCD.."/"..maxCooldown.."|r"
				elseif maxCooldown ~= 0 then
					name = name.." "..maxCooldown.."|r"
				end

				abilityName:SetText(name)

				if not abilityName:IsShown() then
					local modifier = 1.0;
					if (abilityPetType and enemyPetType) then
						modifier = C_PetBattles.GetAttackModifier(abilityPetType, enemyPetType);
					end

					if ( noStrongWeakHints or modifier == 1 ) then
						abilityIcon:SetTexture("Interface\\PetBattles\\BattleBar-AbilityBadge-Neutral");
					elseif ( modifier < 1 ) then
						abilityIcon:SetTexture("Interface\\PetBattles\\BattleBar-AbilityBadge-Weak");
					elseif ( modifier > 1 ) then
						abilityIcon:SetTexture("Interface\\PetBattles\\BattleBar-AbilityBadge-Strong");
					end

					abilityIcon:Show();
					abilityName:Show();
				end
			end
		end
	end
end
--------------------		UnitFrame上色(self.Name上色留下了，貌似还有用处)
hookfunction.PetBattleUnitFrame_UpdateDisplay=function(self)
	if self.petOwner and self.petIndex and self.petIndex <= C_PetBattles.GetNumPets(self.petOwner)  then
		local rarity = C_PetBattles.GetBreedQuality(self.petOwner,self.petIndex)
		local r,g,b = GetItemQualityColor(rarity-1)
		if self.Name then
			self.Name:SetVertexColor(r, g, b);
		end

		if self.Icon then
			if not self.glow then
				self.glow = self:CreateTexture(nil, 'ARTWORK', nil, 2)
				self.glow:SetTexture('Interface/Buttons/UI-ActionButton-Border')
				self.glow:SetSize(self.Icon:GetWidth() * 1.7, self.Icon:GetHeight() * 1.7)
				self.glow:SetPoint('CENTER', self.Icon, 1, 1)
				self.glow:SetBlendMode('ADD')
				self.glow:SetAlpha(.7)
			end
			self.glow:SetVertexColor(r,g,b)
			if not self.BorderAlive and not HPetSaves.HighGlow then
				self.glow:Hide()
			end
		end
	end
end

----- 宠物对战的时候，鼠标放置技能上面。tooltip固定到了右下角。但是放在被动上面却依附在鼠标附近。这应该算是个bug，所以我hook这一段，进行了一点点修改
hookfunction.PetBattleAbilityButton_OnEnter= function(self)
	local petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	if ( self:GetEffectiveAlpha() > 0 and C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, petIndex, self:GetID()) ) then
		PetBattleAbilityTooltip_SetAbility(LE_BATTLE_PET_ALLY, petIndex, self:GetID());
		PetBattleAbilityTooltip_Show("BOTTOMLEFT", self, "TOPRIGHT", 0, 0, self.additionalText);
	elseif ( self.abilityID ) then
		PetBattleAbilityTooltip_SetAbilityByID(LE_BATTLE_PET_ALLY, petIndex, self.abilityID, format(PET_ABILITY_REQUIRES_LEVEL, self.requiredLevel));
		PetBattleAbilityTooltip_Show("BOTTOMLEFT", self, "TOPRIGHT", 0, 0);
	else
		PetBattlePrimaryAbilityTooltip:Hide();
	end
end
----- 点击未收集的宠物链接直接链接到宠物日志
hookfunction.FloatingBattlePet_Show=function(speciesID,level)
	if level==0 then
		FloatingBattlePetTooltip:Hide()
		if (not PetJournalParent) then
			PetJournal_LoadUI();
		end
		if (not PetJournalParent:IsShown()) then
			ShowUIPanel(PetJournalParent);
		end
		PetJournalParent_SetTab(PetJournalParent, 2);
		if (speciesID and speciesID > 0) then
			PetJournal_SelectSpecies(PetJournal, speciesID);
		end
	end
----- 战宠提示框
	local owned = C_PetJournal.GetOwnedBattlePetString(speciesID);
	if owned ~= nil then
		local str
		if  HPetBattleAny.HasPet[speciesID] then
			for _,petInfo in pairs(HPetBattleAny.HasPet[speciesID]) do
				petlink=ITEM_QUALITY_COLORS[petInfo.rarity-1].hex.._G["BATTLE_PET_BREED_QUALITY"..petInfo.rarity].."|r"
				if str then
					str=petlink.."/"..str
				else
					str=petlink
				end
			end
			str = owned.." |cffffff00["..str.."]|r"
		else
			str = "|cffff0000"..NOT_COLLECTED.."!|r"
		end
		if str then FloatingBattlePetTooltip.Owned:SetText(str) end
	end
end
----- 战宠鼠标提示
hookfunction.BattlePetToolTip_Show=function(speciesID, level, breedQuality, maxHealth, power, speed, customName)
	local owned = C_PetJournal.GetOwnedBattlePetString(speciesID);
	if owned ~= nil then
		local str
		if  HPetBattleAny.HasPet[speciesID] then
			for _,petInfo in pairs(HPetBattleAny.HasPet[speciesID]) do
				petlink=ITEM_QUALITY_COLORS[petInfo.rarity-1].hex.._G["BATTLE_PET_BREED_QUALITY"..petInfo.rarity].."|r"
				if str then
					str=petlink.."/"..str
				else
					str=petlink
				end
			end
			str = owned.." |cffffff00["..str.."]|r"
		else
			str = "|cffff0000"..NOT_COLLECTED.."!|r"
		end
		if str then BattlePetTooltip.Owned:SetText(str) end
----- 修复该鼠标大小问题
		BattlePetTooltip:SetSize(260,140)
	end
end
----- 战斗宠物提示tooltip(收集提示已自带5.1)
hookfunction.BattlePetTooltipTemplate_SetBattlePet=function(frame,data)
	if data.level ~=0 and data.breedQuality~=-1 then
		local petstate=data
		petstate.health=data.maxHealth
		petstate.rarity=data.breedQuality+1
		local ghealth, gpower, gspeed, breedID= HPetBattleAny.ShowMaxValue(petstate,data.speciesID)
		frame.Health:SetText(format("%d%s",data.maxHealth,ghealth))
		frame.Power:SetText(format("%d%s",data.power,gpower))
		frame.Speed:SetText(format("%d%s",data.speed,gspeed))
		if breedID then
			frame.PetType:SetText(format("%s(%s)",frame.PetType:GetText(),breedID))
		end
		if not frame.Name:GetText() then frame.Name:SetText(data.customName) end
	end
end

----- 点击头像,链接到宠物日志
hookfunction.PetBattleUnitFrame_OnClick=function(self,button)
	if button=="LeftButton" then
		local speciesID = C_PetBattles.GetPetSpeciesID(self.petOwner,self.petIndex)
		if speciesID then hookfunction.FloatingBattlePet_Show(speciesID,0) end
		if self.petOwner == 1 then
			for i = 1, C_PetBattles.GetNumPets(self.petOwner) do
				local petID = C_PetJournal.GetPetLoadOutInfo(i)
				local tspeciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType= C_PetJournal.GetPetInfoByPetID(petID)
				if tspeciesID == speciesID and C_PetBattles.GetLevel(self.petOwner,self.petIndex) == level and C_PetBattles.GetXP(self.petOwner,self.petIndex) == xp and C_PetBattles.GetPetType(self.petOwner,self.petIndex) == petType and C_PetBattles.GetName(self.petOwner,self.petIndex) == (customName or name) and select(2,C_PetBattles.GetName(self.petOwner,self.petIndex)) == name then
--~ 					if petID then
						PetJournal_SelectPet(PetJournal,petID)
						return
--~ 					end
				end
			end
		elseif self.petOwner == 2  then
			if HPetAllInfoFrame.ready then HPetAllInfoFrame:Update(speciesID,HPetBattleAny.EnemyPetInfo[self.petIndex].breedID) end
		end
	end
end

----- 修复宠物对战中一些快捷键失效的问题
hookfunction.PetBattleFrame_ButtonDown=function(id,func)
	if id==6 or id==12 then
		local button
		if id==6 then
			button = PetBattleFrame.BottomFrame.ForfeitButton
			if (not button) then
				return;
			end
		elseif id==12 then
			button = PetBattleFrame.BottomFrame.TurnTimer.SkipButton
			if (not button) then
				return;
			end
			if ( button:IsEnabled() ) then
				button.Left:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down");
				button.Middle:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down");
				button.Right:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down");
			end
		end
		if ( button:GetButtonState() == "NORMAL" ) then
			button:SetButtonState("PUSHED");
		end
		if ( GetCVarBool("ActionButtonUseKeydown") ) then
			if id == 6 and StaticPopup1:IsShown() then
					StaticPopup_Hide("PET_BATTLE_FORFEIT",nil);
					button:SetButtonState("NORMAL");
			else
			button:Click();
			end
		end
	end
	if PetBattleFrame.BottomFrame.PetSelectionFrame:IsShown() then
		if id==1 or id==2 or id==3 then
			return
		end
	end
	func(id)
end

hookfunction.PetBattleFrame_ButtonUp=function(id,func)
	if id==4 or id== 5 or id==6 or id==12 then
		local button
		if id==4 then
			button=PetBattleFrame.BottomFrame["SwitchPetButton"]
		elseif id==5 then
			button=PetBattleFrame.BottomFrame["CatchButton"]
		elseif id==6 then
			button=PetBattleFrame.BottomFrame["ForfeitButton"]
		elseif id==12 then
			button = PetBattleFrame.BottomFrame.TurnTimer.SkipButton
			if ( button:IsEnabled() ) then
				button.Left:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up");
				button.Middle:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up");
				button.Right:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up");
			end
		else
			return
		end
		if ( button:GetButtonState() == "PUSHED" ) then
			button:SetButtonState("NORMAL");
			if ( not GetCVarBool("ActionButtonUseKeydown") ) and not ( IsModifiedClick() ) then
				if id == 6 and StaticPopup1:IsShown() then
					StaticPopup_Hide("PET_BATTLE_FORFEIT",nil);
					button:SetButtonState("NORMAL");
				else
					button:Click();
				end
			end
		end
	else
		if PetBattleFrame.BottomFrame.PetSelectionFrame:IsShown() then
			if C_PetBattles.CanPetSwapIn(id) then
				C_PetBattles.ChangePet(id);
				PetBattlePetSelectionFrame_Hide(PetBattleFrame.BottomFrame.PetSelectionFrame);
			end
			return
		end
		func(id)
	end
end
hookfunction.PetBattleFrame_UpdateAbilityButtonHotKeys=function(self)
	PetBattleAbilityButton_UpdateHotKey(self.BottomFrame.ForfeitButton);
	local button=PetBattleFrame.BottomFrame.TurnTimer.SkipButton
	if not button[HotKey] then
		button.HotKey=button:CreateFontString(nil,"OVERLAY","NumberFontNormalSmallGray")
		button.HotKey:SetPoint("TOPRIGHT",-1,-2)
	end
	local key = GetBindingKey("ACTIONBUTTON12");
	if ( key ) then
		button.HotKey:SetText(key);
		button.HotKey:Show();
	else
		button.HotKey:Hide();
	end
end
hookfunction.StaticPopup_Show=function(str)
	if str=="PET_BATTLE_FORFEIT" and HPetSaves.FastForfeit then
		if not HPetSaves.Sound and HPetBattleAny.EnemyPetInfo and HPetBattleAny.EnemyPetInfo.FindBlue then
		else
			StaticPopup_Hide("PET_BATTLE_FORFEIT",nil);
			C_PetBattles.ForfeitGame()
		end
	end
end

----技能ID
hookfunction.SharedPetBattleAbilityTooltip_SetAbility=function(self, abilityInfo, additionalTex)
	local abilityID = abilityInfo:GetAbilityID();
	local name = select(2, C_PetBattles.GetAbilityInfoByID(abilityID))
	self.Name:SetText(name.."("..abilityID..")");
end








---------------------------手动xxxxxxxxxx
for i = 1, 6 do
	_G["PetJournalPetCardSpell"..i]:HookScript("OnClick",function(self)
		if not PetJournalPetCard.petID then return end
		if (not IsModifiedClick() and not self.LevelRequirement:IsShown()) or (IsModifiedClick() and self.LevelRequirement:IsShown()) then
			local pos = string.gsub("%1%2%3","(.*)(%%"..((i>3) and (i-3) or i)..")(.*)","%1"..i.."%3")
			if pos then
				HPetSaves.PetAblitys[PetJournalPetCard.petID] = string.gsub(HPetSaves.PetAblitys[PetJournalPetCard.petID] or "000","^(.)(.)(.)$",pos)
			end
			PetJournal_UpdatePetCard(PetJournalPetCard)
		end
	end)
end
---------------------------自动保存设置宠物技能组合
local SaveSkillInfo = function(loadoutID,index,abilityID)
	if not HPetSaves.AutoSaveAbility then return end
	if not HPetSaves.PetAblitys then HPetSaves.PetAblitys={} end

	local abilities = PetJournal.Loadout["Pet"..loadoutID].abilities
	if not abilities then return end

	local petID = C_PetJournal.GetPetLoadOutInfo(loadoutID)
	local pos
	if abilityID == abilities[index] then
		pos = string.gsub("%1%2%3","(.*)(%%"..index..")(.*)","%1"..index.."%3")
	elseif abilityID == abilities[index+3] then
		pos = string.gsub("%1%2%3","(.*)(%%"..index..")(.*)","%1"..(index+3).."%3")
	end
	if pos then
		HPetSaves.PetAblitys[petID] = string.gsub(HPetSaves.PetAblitys[petID] or "123","^(.)(.)(.)$",pos)
	end
end

local LoadSkillInfo = function(loadoutID,petID)
	if not HPetSaves.AutoSaveAbility then return end
	if not HPetSaves.PetAblitys then HPetSaves.PetAblitys={} end

	local str = HPetSaves.PetAblitys[petID]
	if not str then return end

	local petID = C_PetJournal.GetPetLoadOutInfo(loadoutID)
	local speciesID = C_PetJournal.GetPetInfoByPetID(petID)
	local abilities = {}
	C_PetJournal.GetPetAbilityList(speciesID, abilities)
	for i = 1,3 do
		local skindex = tonumber(string.sub(str,i,i))
		local abilityID = abilities[skindex]
		if abilityID and skindex ~= i then
			C_PetJournal.SetAbility(loadoutID, i, abilityID)
		end
	end
end


hooksecurefunc(C_PetJournal, "SetAbility",SaveSkillInfo)
hooksecurefunc(C_PetJournal,"SetPetLoadOutInfo",LoadSkillInfo)
