if GetLocale() == "zhCN" then
	HPetLocals = {
			----------Options
			["HPet Options"]				= "HPet 设置",
			["Pet All Info"]				= "宠物信息",

			["Loading"]						= "已开启，输入%s进入设置界面",

			["Message"]						= "文字提示",	--ShowMsg
			["MessageTooltip"]				= "进入对战后，聊天窗口列出敌对宠物信息以及收集情况",

			["Sound"]						= "声音提示",		--Sound
			["SoundTooltip"]				= "蓝色/蓝色以上可捕捉宠物发出声音提示。",

			["OnlyInPetInfo"]				= "文字提示位置",
			["OnlyInPetInfoTooltip"]		= "勾选后，文字提示将只跟随宠物对战信息",

			["HighGlow"]					= "宠物头像着色",
			["HighGlowTooltip"]				= "战斗中用品质颜色对宠物头像着色",

			["EnemyAbility"]				= "敌对技能图标",
			["EnemyAbilityTooltip"]			= "宠物对战中显示敌对技能(技能CD),该图标可以移动。",

			["LockEnemyAbility"]			= "锁定敌对技能图标",
			["LockEnemyAbilityTooltip"]		= "解锁或者移动敌对技能图标",

			["EnemyAbilityScale"]			= "敌对技能图标缩放", --EnemyAbScale
			["EnemyAbilityScaleTooltip"]	= "缩放敌对技能图标敌对技能",

			["PetGrowInfo"]					= "显示成长值",	--ShowGrowInfo
			["PetGrowInfoTooltip"]			= "显示成长值",

			["PetGreedInfo"]				= "显示新成长值",
			["PetGreedInfoTooltip"]			= "新成长值需要x基数得到准确成长值|n品质基数:劣质x1.0 普通1.1 优秀1.2 精良1.3 |n跨越品质比较(用于5.1的战斗石)",

			["PetBreedInfo"]				= "显示Breed",

			["ShowBreedId"]					= "显示BreedID",
			["ShowBreedIdTooltip"]			= "在宠物日志的宠物类别旁边显示BreedID",

			["FastForfeit"]					= "快速放弃",
			["FastForfeitTooltip"]			= "|cff00ffff勾选后，放弃键将直接放弃战斗，无需确认|r",

			["OtherTooltip"]				= "额外鼠标提示",
			["OtherTooltipTooltip"]			= "鼠标提示中加入宠物信息(收集/来源)",

			["bottom title"]				= "作者：上官晓雾|n发布：NGA(宠物区)|nID:上官晓雾#5190/zhCN",

			["lock rarity"]					= "锁定品质",
			["Grow Point"]					= "成长值:",
			["Greed Point"]					= "品值:",
			["Breed Point"]					= "Breed:",
			["Breed"]						= "品种",
			["Switch"]						= "切换",
			["Base Points"]					= "基础值",

			----------other
			["Only collected"]				= "只收集了",
			["this is"]						= "第%s只",
--- 			["Loading info"]				= "寵物辨別開啟,輸入%s用以設置信息提示",
			["Search Help"]					= "搜索帮助",
			["searchhelp1"]					= "[/hpq s xxx]xxx为宠物任意来源信息",
			["searchhelp2"]					= "[/hpq ss XXX]xxx宠物任意技能信息(可以是技能内的文本)",
			["search key"]					= "搜索关键字为:",
			["search remove key"]			= "排除关键字为:",
		}
elseif GetLocale() == "zhTW" then
		HPetLocals = {
			----------Options
			["HPet Options"] = "HPet 設置",
			["Pet All Info"]				= "寵物信息",

			["Loading"]						= "已開啟，輸入%s進入設置介面",

			["Message"] = "文字提示", --ShowMsg
			["MessageTooltip"] = "進入對戰後，聊天窗口列出敵對寵物信息以及收集情況",

			["Sound"] = "聲音提示", --Sound
			["SoundTooltip"] = "藍色/藍色以上可捕捉寵物發出聲音提示。",

			["OnlyInPetInfo"]				= "文字提示信息",
			["OnlyInPetInfoTooltip"]		= "勾選后，文字提示信息將只跟隨寵物對戰信息",

			["HighGlow"]					= "寵物頭像上色",

			["EnemyAbility"] = "敵對技能圖標",
			["EnemyAbilityTooltip"] = "寵物對戰中顯示敵對技能(技能CD),该圖標可以移動。",

			["LockEnemyAbility"] = "鎖定敵對技能圖標",
			["LockEnemyAbilityTooltip"] = "解鎖或者移動敵對技能圖標",

			["EnemyAbilityScale"] = "敵對技能圖標縮放", --EnemyAbScale
			["EnemyAbilityScaleTooltip"] = "縮放敵對技能圖標",

			["PetGrowInfo"] = "顯示成長值", --ShowGrowInfo
			["PetGrowInfoTooltip"] = "顯示成長值",

			["PetGreedInfo"] = "顯示品值",
			["PetGreedInfoTooltip"] = "新成長值需要x基數得到準確成長值|n品質基數:劣質x1.0 普通1.1 優秀1.2 精良1.3 |n跨越品質比較(用於5.1的戰鬥石)",

			["PetBreedInfo"]				= "顯示Breed",

			["ShowBreedId"]					= "显示BreedID",
			["ShowBreedIdTooltip"]				= "在宠物日志的宠物类别旁边显示BreedID",

			["FastForfeit"]					= "快速放棄",
			["FastForfeitTooltip"]				= "|cff00ffff按下放棄快捷鍵直接放棄戰鬥，無需確認|r",

			["OtherTooltip"]				= "額外鼠標提示",
			["OtherTooltipTooltip"]			= "鼠標提示中加入寵物信息(收集/來源)",

			["bottom title"] = "作者：上官曉霧|n發布：NGA(寵物區)|nID:上官晓雾#5190/zhCN",

			["lock rarity"]					= "鎖定品質",
			["Grow Point"]					= "成長值:",
			["Greed Point"]					= "品值:",
			["Breed Point"]					= "Breed:",
			["Breed"]						= "品種",
			["Switch"]						= "切换",
			["Base Points"]					= "基礎值",

			----------other
			["Only collected"] = "只收集了",
			["this is"]			= "第%s隻",
			["Search Help"] = "搜索幫助",
			["searchhelp1"] = "[/hpq s xxx]xxx為寵物任意來源信息",
			["searchhelp2"] = "[/hpq ss XXX]xxx寵物任意技能信息(可以是技能內的文本)",
			["search key"] = "搜索關鍵字為:",
			["search remove key"] = "排除關鍵字為:",
		}
else
	HPetLocals = {
		---------- Options
		["HPet Options"] = "HPet Options",
		["Pet All Info"]				= "Pet All Info",

		["Loading"]						= "is Loaded，type %s to configure",

		["Message"] = "text prompt",
		["MessageTooltip"] = "enter the PetBattle, the chat window lists hostile pet information and the collection of",

		["Sound"] = "sound",
		["SoundTooltip"] = "Rare pet may capture of Sound Alarm.",

		["OnlyInPetInfo"]				= "text position",

		["HighGlow"]					= "color pet unit",

		["EnemyAbility"] = "enemy skill",
		["EnemyAbilityTooltip"] = "In PetBattle,Show skills(skills CD) of emeny,Drag the icons can be moved.",

		["LockEnemyAbility"] = "lock enemy skill",
		["LockEnemyAbilityTooltip"] = "unlock or move enemy skill icons",

		["EnemyAbilityScale"] = "enemy skill scaling",
		["EnemyAbilityScaleTooltip"] = "Zoom enemy skill icons",

		["PetGrowInfo"] = "growth value",
		["PetGrowInfoTooltip"] = "display growth value",

		["PetGreedInfo"] = "greed value",

		["PetBreedInfo"]				= "Breed value",

		["ShowBreedId"]					= "BreedID",

		["FastForfeit"]					= "Fast Forfeit",
		["FastForfeitTooltip"]				= "|cff00ffffDown Forfeit's button without confirm|r",

		["OtherTooltip"]				= "OtherTooltip",
		["OtherTooltipTooltip"]			= "Add something to GameTooltip(Collected/sourceText)",

		["bottom title"] = "作者：上官曉霧|n發布：NGA(寵物區)|nID:上官晓雾#5190/zhCN",

		["lock rarity"]					= "lock rarity",
		["Grow Point"]					= "Grow::",
		["Greed Point"]					= "Greed:",
		["Breed Point"]					= "Breed:",
		["Breed"]						= "Breed",
		["Switch"]						= "Switch",
		["Base Points"]					= "Base Points",

		---------- other
		["Only collected"] = "collect only",
		["this is"]			= "the %s is ",
		["Loading info"] = "the pet identify open input% s to set the message alert",
		["Search Help"] = "Search Help",
		["searchhelp1"] = "[/ hpq s xxx] xxx as a the pet any source of information",
		["searchhelp2"] = "[/ hpq ss XXX] xxx pet any skills (can be skills within the text),",
		["search key"] = "Search for the key word:",
		["search remove key"] = "Negative keyword:",
	}
end
