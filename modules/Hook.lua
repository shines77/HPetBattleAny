-----####Hook1.92####
-------1.9:快速放弃同时判断是否出现精良宠物
-------1.91:快速放弃的额外判断需要关闭声音才会起效
-------1.92:对HPetBattleAny.CreateLinkByInfo的HOOK更严谨一点。

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

hookfunction.init = function()
	PetBattlePrimaryUnitTooltip:HookScript("OnHide",function() GameTooltip:Hide() end)

	PetBattleFrame.BottomFrame.ForfeitButton:SetID(6)

	for a,b in pairs(HPetBattleAny.hook) do
		if a=="PetBattleUnitFrame_OnClick" then
			--------------------------点击头像
			PetBattleFrame.ActiveAlly:SetScript("OnClick",b)
			PetBattleFrame.ActiveEnemy:SetScript("OnClick",b)
			PetBattleFrame.Ally2:SetScript("OnClick",b)
			PetBattleFrame.Ally3:SetScript("OnClick",b)
			PetBattleFrame.Enemy2:SetScript("OnClick",b)
			PetBattleFrame.Enemy3:SetScript("OnClick",b)
		elseif a=="PetBattleFrame_ButtonUp" or a=="PetBattleFrame_ButtonDown" then
			local temp=_G[a]
			_G[a]=function(id)
				b(id,temp)
			end
		elseif a=="PetJournalUtil_GetDisplayName" then
			PetJournalUtil_GetDisplayName=b
		elseif a~=0 and a~="init" then
			hooksecurefunc(a,b)
		end
		PetJournal.listScroll.update = PetJournal_UpdatePetList;
	end

	if HPetBattleAny.CreateLinkByInfo then
		C_PetJournal.GetBattlePetLink=function(id)
			return HPetBattleAny.CreateLinkByInfo(id)
		end
		HP_L=function(id,mlevel,mhealth,mpower,mspeed,mrarity)
			if mrarity~=nil then
				local data={level=mlevel,health=mhealth,power=mpower,speed=mspeed,rarity=mrarity}
				print(HPetBattleAny.CreateLinkByInfo(id,data))
			elseif HPetDate[id] then
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
end

--[[	Hook	]]--
--------------------		鼠标提示/头像
hookfunction.PetBattleUnitTooltip_UpdateForUnit = function(self, petOwner, petIndex)
	local r,g,b,hex=GetItemQualityColor(C_PetBattles.GetBreedQuality(petOwner,petIndex)-1)
	local speciesID=C_PetBattles.GetPetSpeciesID(petOwner,petIndex)
	local name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
	local strbreedId=""
------- 成长值
	GameTooltip:SetOwner(self,"ANCHOR_BOTTOM");
	if petOwner == LE_BATTLE_PET_ENEMY and HPetBattleAny.EnemyPetInfo[petIndex] then
		local EnemyPet=HPetBattleAny.EnemyPetInfo[petIndex]
		local ghealth, gpower, gspeed, breedId = HPetBattleAny.ShowMaxValue(EnemyPet,speciesID,true)
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
		end
	end

----- 一个额外的鼠标提示
	if sourceText and sourceText~="" and HPetBattleAny.GetPetCollectedInfo then
		local str1,str2 = HPetBattleAny:GetPetCollectedInfo(HPetBattleAny.HasPet[speciesID])
--~ 		GameTooltip:SetOwner(self,"ANCHOR_BOTTOM");
		GameTooltip:AddDoubleLine(str1..str2,nil, 1, 1, 1);
		GameTooltip:AddLine(sourceText, 1, 1, 1, true);
		GameTooltip:Show();
	end
----- 	技能CD
	if true then
		for i = 1, NUM_BATTLE_PET_ABILITIES do
			local id, name, icon, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(petOwner, petIndex, i);
			local enemyPetType = C_PetBattles.GetPetType(PetBattleUtil_GetOtherPlayer(petOwner), C_PetBattles.GetActivePet(PetBattleUtil_GetOtherPlayer(petOwner)));
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
					name = name.." CD:"..abilityCD.."/"..maxCooldown.."|r"
				elseif maxCooldown ~= 0 then
					name = name.." CD:"..maxCooldown.."|r"
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
--------------------		UnitFrame上色
hookfunction.PetBattleUnitFrame_UpdateDisplay=function(self)
	if self.petOwner and self.petIndex and self.petIndex <= C_PetBattles.GetNumPets(self.petOwner)  then
		local rarity = C_PetBattles.GetBreedQuality(self.petOwner,self.petIndex)
		local r,g,b = GetItemQualityColor(rarity-1)
		if (self.Border) then
			if (ENABLE_COLORBLIND_MODE == "1") then
				self.Name:SetText(self.Name:GetText().." (".._G["BATTLE_PET_BREED_QUALITY"..rarity]..")");
			else
				self.Border:SetVertexColor(r, g, b);
			end
		end

		if self.Name then
			self.Name:SetVertexColor(r, g, b);
		end

		if (self.BorderAlive ) then
			if self.BorderAlive:IsShown() then
				self.BorderAlive:SetVertexColor(r, g, b);
			end
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
------ 宠物日志滚动列表条刷新
hookfunction.PetJournal_UpdatePetList=function()
	local scrollFrame = PetJournal.listScroll;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local petButtons = scrollFrame.buttons;
	local pet, index;

	local isWild = PetJournal.isWild;

	local numPets, numOwned = C_PetJournal.GetNumPets(isWild);
	PetJournal.PetCount.Count:SetText(numOwned);

	local summonedPetID = C_PetJournal.GetSummonedPetID();

	for i = 1,#petButtons do
		pet = petButtons[i];
		index = offset + i;
		if index <= numPets then
			local petID, speciesID, isOwned, customName, level, favorite, isRevoked, name, icon, petType, creatureID, sourceText, description, isWildPet, canBattle = C_PetJournal.GetPetInfoByIndex(index, isWild);
			if isOwned then
				local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID);
				if (isWildPet) or rarity then
					pet.iconBorder:Show();
					pet.iconBorder:SetVertexColor(ITEM_QUALITY_COLORS[rarity-1].r, ITEM_QUALITY_COLORS[rarity-1].g, ITEM_QUALITY_COLORS[rarity-1].b);
				else
					pet.iconBorder:Hide();
				end
			end
		end
	end
end
----- 对没有标示品质的宠物进行标示品质
hookfunction.PetJournal_UpdatePetCard=function(self)
	local strbreedId=""
	if PetJournalPetCard.petID then
		local speciesID, customName, level, xp, maxXp, displayID, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable = C_PetJournal.GetPetInfoByPetID(PetJournalPetCard.petID)
		local _,health,power,speed,rarity = C_PetJournal.GetPetStats(PetJournalPetCard.petID)
		local petstate={["level"]=level,["health"]=health,["power"]=power,["speed"]=speed,["rarity"]=rarity}
		if canBattle and self.QualityFrame:IsShown()==nil then
			if rarity then
				self.QualityFrame.quality:SetText(_G["BATTLE_PET_BREED_QUALITY"..rarity]);
				local color = ITEM_QUALITY_COLORS[rarity-1];
				self.QualityFrame.quality:SetVertexColor(color.r, color.g, color.b);
				self.QualityFrame:Show();
			end
		end
		if speciesID then
			local ghealth, gpower, gspeed, breedId= HPetBattleAny.ShowMaxValue(petstate,speciesID)
			self.HealthFrame.health:SetText(format("%d%s",health,ghealth))
			self.PowerFrame.power:SetText(format("%d%s",power,gpower))
			self.SpeedFrame.speed:SetText(format("%d%s",speed,gspeed))
			if breedId and HPetSaves.ShowBreedId then
				strbreedId = "("..(breedId <=12 and breedId or (breedId-10)).."/"..(breedId<=12 and (breedId+10) or breedId)..")"
			end
			PetJournalPetCard.breedId=breedId
		end
	else
		PetJournalPetCard.breedId=nil
	end
	if PetJournalPetCard.speciesID then
		local petType=select(3,C_PetJournal.GetPetInfoBySpeciesID(PetJournalPetCard.speciesID))
		PetJournalPetCard.TypeInfo.type:SetText(_G["BATTLE_PET_NAME_"..petType].."("..PetJournalPetCard.speciesID..")"..strbreedId)
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
end

----- 战斗宠物提示tooltip
hookfunction.BattlePetTooltipTemplate_SetBattlePet=function(frame,data)
	local mPet=HPetBattleAny.HasPet[data.speciesID]
	if mPet then
		frame.BattlePet:SetText(TOOLTIP_BATTLE_PET.."|cffffff00".."("..COLLECTED..")|r");
	else
		frame.BattlePet:SetText(TOOLTIP_BATTLE_PET.."|cffff0000".."("..NOT_COLLECTED..")|r");
	end

	if data.level ~=0 and data.breedQuality~=-1 then
		local petstate=data
		petstate.health=data.maxHealth
		petstate.rarity=data.breedQuality+1
		local ghealth, gpower, gspeed, breedId= HPetBattleAny.ShowMaxValue(petstate,data.speciesID)
		frame.Health:SetText(format("%d%s",data.maxHealth,ghealth))
		frame.Power:SetText(format("%d%s",data.power,gpower))
		frame.Speed:SetText(format("%d%s",data.speed,gspeed))
		if breedId then
			frame.PetType:SetText(format("%s(%s)",frame.PetType:GetText(),breedId))
		end
	end

end

----------------------------------------------------------------------
----- 点击头像,链接到宠物日志
hookfunction.PetBattleUnitFrame_OnClick=function(self,button)
	if button=="LeftButton" then
		local speciesID = C_PetBattles.GetPetSpeciesID(self.petOwner,self.petIndex)
		if speciesID then hookfunction.FloatingBattlePet_Show(speciesID,0) end
	end
end
----------删除宠物，提醒消息中附带宠物颜色
hookfunction.PetJournalUtil_GetDisplayName=function(petID)
	local speciesID, customName, level, xp, maxXp, displayID, petName, petIcon, petType, creatureID = C_PetJournal.GetPetInfoByPetID(petID);
	local rarity = select(5,C_PetJournal.GetPetStats(petID))
	if ( customName ) then
		return ITEM_QUALITY_COLORS[rarity-1].hex..customName.."|r";
	else
		return ITEM_QUALITY_COLORS[rarity-1].hex..petName.."|r";
	end
end

----- 修复宠物对战中一些快捷键失效的问题
--~ local tempPetBattleFrame_ButtonDown=PetBattleFrame_ButtonDown
--~ PetBattleFrame_ButtonDown=function(id) end
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
--~ local tempPetBattleFrame_ButtonUp=PetBattleFrame_ButtonUp
--~ PetBattleFrame_ButtonUp=function(id) end
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
		if HPetSaves.Sound or not HPetBattleAny.EnemyPetInfo.FindBlue then
			StaticPopup_Hide("PET_BATTLE_FORFEIT",nil);
			C_PetBattles.ForfeitGame()
		end
	end
end
