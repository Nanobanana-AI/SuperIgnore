-- SuperIgnore v1.1.0
-- A lightweight, account-wide ignore list management tool.
-- Copyright (c) 2026 okqiyi. All rights reserved.

-- 1. 初始化数据库 (新增关键词库)
SuperIgnoreDB = SuperIgnoreDB or {}
SuperIgnoreKeywordsDB = SuperIgnoreKeywordsDB or {}

-- 2. 聊天过滤模块：屏蔽喊话和私聊
local function ChatFilter(self, event, msg, author, ...)
    -- 【新增】关键词/正则匹配拦截
    if SuperIgnoreKeywordsDB then
        for keyword, _ in pairs(SuperIgnoreKeywordsDB) do
            -- 使用 Lua 的 find 进行正则/字符串匹配
            if msg:find(keyword) then
                return true -- 只要触发关键词，整条消息直接蒸发
            end
        end
    end

    
    -- 将 author 拆分为名字和服务器
    local name, realm = strsplit("-", author)
    
    -- 如果拆分后没有服务器名（说明是同服玩家喊话），自动获取并补全当前服务器
    if not realm or realm == "" then
        realm = GetNormalizedRealmName()
    end
    
    -- 拼接成和数据库里一模一样的 "名字-服务器" 绝对标准格式
    local fullName = name .. "-" .. realm

    -- 直接用补全后的完整名字去匹配黑名单（为了保险，保留对原始 author 的回退检查）
    if SuperIgnoreDB[fullName] or SuperIgnoreDB[author] then
        return true 
    end
    
    return false
end


-- 注册需要过滤的聊天频道
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilter)

-- 3. 组队与交易拦截模块：自动拒绝邀请
local frame = CreateFrame("Frame")
frame:RegisterEvent("PARTY_INVITE_REQUEST")
frame:RegisterEvent("TRADE_REQUEST") -- 【新增】监听交易请求
frame:SetScript("OnEvent", function(self, event, sender, ...)
    if event == "PARTY_INVITE_REQUEST" then
        local cleanSender = Ambiguate(sender, "none")
        if SuperIgnoreDB[sender] or SuperIgnoreDB[cleanSender] then
            DeclineGroup()
            StaticPopup_Hide("PARTY_INVITE")
            print("|cffff0000[SuperIgnore]|r 已自动拒绝黑名单玩家 " .. sender .. " 的组队邀请。")
        end
    elseif event == "TRADE_REQUEST" then
        local cleanSender = Ambiguate(sender, "none")
        if SuperIgnoreDB[sender] or SuperIgnoreDB[cleanSender] then
            CancelTrade() -- 【新增】强行取消交易弹窗
            print("|cffff0000[SuperIgnore]|r 已自动拒绝黑名单玩家 " .. sender .. " 的交易请求。")
        end
    end
end)


-- 4. 独立 UI 窗口 (带目标名字确认与防呆设计)
local f = CreateFrame("Frame", "SuperIgnoreUI", UIParent, "BasicFrameTemplateWithInset")
-- 高度从 160 增加到 180，给上方显示名字腾出空间
f:SetSize(300, 180) 
f:SetPoint("CENTER")
f:Hide()
f.title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
f.title:SetPoint("CENTER", f.TitleBg, "CENTER", 0, 0)
f.title:SetText("添加超级黑名单")

-- 【新增】目标玩家名字显示区域
f.targetNameText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
f.targetNameText:SetPoint("TOP", 0, -35)
f.targetNameText:SetText("目标：无")

-- 输入框
f.editBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
f.editBox:SetSize(260, 30)
-- 往下挪到了 -65 的位置，给上面的名字让位
f.editBox:SetPoint("TOP", 0, -65) 
f.editBox:SetAutoFocus(true)

-- 确认按钮
f.confirm = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
f.confirm:SetSize(80, 25)
f.confirm:SetPoint("BOTTOMLEFT", 40, 20)
f.confirm:SetText("确认")

-- 【新增】取消按钮 (防手滑)
f.cancel = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
f.cancel:SetSize(80, 25)
f.cancel:SetPoint("BOTTOMRIGHT", -40, 20)
f.cancel:SetText("取消")
f.cancel:SetScript("OnClick", function() f:Hide() end)

-- 快捷按钮逻辑
local reasons = {"代练", "广告", "喷子", "SB"}
for i, reason in ipairs(reasons) do
    local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    btn:SetSize(60, 22)
    btn:SetText(reason)
    -- 动态排布
    btn:SetPoint("TOPLEFT", f.editBox, "BOTTOMLEFT", (i-1)*65, -5)
    btn:SetScript("OnClick", function() f.editBox:SetText(reason) end)
end

-- 逻辑处理

f.confirm:SetScript("OnClick", function()
    local name = f.playerName
    local reason = f.editBox:GetText()
    if reason == "" then reason = "手动添加" end
    
    -- 确保库存在，防止极低概率的报错
    SuperIgnoreDB = SuperIgnoreDB or {} 
    
    -- 直接写入内存，魔兽引擎会自动负责落盘保存
    SuperIgnoreDB[name] = {reason = reason, time = date("%Y-%m-%d %H:%M")}
    
    print("|cffff0000[SuperIgnore]|r 已拉黑 " .. name .. "。原因：" .. reason)
    f:Hide()
end)

-- 供右键菜单和斜杠命令调用的统一入口
function ShowSuperIgnoreUI(name)
    if not name or name == "" then return end

    -- 如果右键获取到的名字是个残次品（没带服务器），直接在控制台报错，绝不拉起弹窗！
    if not string.find(name, "-") then
        print("|cffff0000[SuperIgnore]|r 无法获取该玩家的服务器信息，拉黑失败！")
        return
    end

    f.playerName = name
    f.targetNameText:SetText("目标：|cff00ff00" .. name .. "|r") 
    f.editBox:SetText("")
    f:Show()
end

    
-- 5. 修正后的菜单注入逻辑（终极兼容版，彻底解决跨服与消失问题）
local function InjectSuperIgnore(ownerRegion, rootDescription, contextData)
    if not contextData then return end
    
    local finalName = nil
    local myRealm = GetNormalizedRealmName() or ""
    
    -- 1. 头像右键 (最高优先级，解决跨服副本里只有名字没有服务器的 Bug)
    if contextData.unit and type(contextData.unit) == "string" then
        local name, realm = UnitName(contextData.unit)
        if name then
            if realm and realm ~= "" then
                finalName = name .. "-" .. realm
            else
                finalName = name .. "-" .. myRealm
            end
        end
    end
    
    -- 2. 聊天频道右键 (如果不是点头像，而是点聊天频道)
    if not finalName and contextData.name then
        finalName = contextData.name
        -- 跨服聊天时，原生系统可能会把服务器单独放在 contextData.server 里
        if not string.find(finalName, "-") and contextData.server and contextData.server ~= "" then
            finalName = finalName .. "-" .. contextData.server
        end
    end
    
    -- 3. 聊天链接提取 (保底)
    if not finalName and contextData.link then
        local linkName = string.match(contextData.link, "player:([^:]+)")
        if linkName then finalName = linkName end
    end
    
    -- 4. 终极格式化与生成菜单
    if finalName and finalName ~= "" then
        -- 暴雪API返回的服务器名常常带隐形空格，必须干掉
        finalName = string.gsub(finalName, "%s+", "")
        
        -- 最终防呆：如果到这一步还没有 "-"，只能补全当前服务器
        if not string.find(finalName, "-") and myRealm ~= "" then
            finalName = finalName .. "-" .. myRealm
        end
        
        -- 防手滑设计：不在自己的头像上生成拉黑按钮
        local myName = UnitName("player")
        if finalName == (myName .. "-" .. myRealm) then return end
        
        rootDescription:CreateDivider()
        rootDescription:CreateButton("加入超级黑名单", function()
            ShowSuperIgnoreUI(finalName)
        end)
    end
end

-- 保持菜单注册逻辑不变
if Menu and Menu.ModifyMenu then
    local menuList = {"MENU_UNIT_PLAYER", "MENU_UNIT_TARGET", "MENU_UNIT_PARTY", "MENU_UNIT_RAID_PLAYER", "MENU_CHAT_PLAYER", "MENU_CHAT_LINK", "MENU_CHAT_ROSTER", "MENU_UNIT_FRIEND"}
    for _, menuID in ipairs(menuList) do
        Menu.ModifyMenu(menuID, InjectSuperIgnore)
    end
end

-- 6. 斜杠命令 (极简路由版：只负责打开面板)
SLASH_SUPERIGNORE1 = "/si"
SlashCmdList["SUPERIGNORE"] = function()
    -- 【新增】战斗状态安全拦截
    if InCombatLockdown() then
        print("|cffff0000[SuperIgnore]|r 战斗中系统限制，无法打开设置面板，请脱战后再试。")
        return
    end

    if SuperIgnoreCategory then
        -- 直接翻页到我们的插件管理面板
        Settings.OpenToCategory(SuperIgnoreCategory:GetID())
    else
        print("|cffff0000[SuperIgnore]|r 错误：设置面板未初始化。")
    end
end





-- 7. 插件管理面板 (带玩家/关键词/导出导入 三大模块)
local panel = CreateFrame("Frame", "SuperIgnoreOptionsPanel")

-- 动态读取 TOC 文件中的版本号 (纯净版)
local addonVersion = C_AddOns.GetAddOnMetadata("SuperIgnore", "Version")

panel.name = "SuperIgnore" 

-- ==========================================
-- 标题与简介区域
-- ==========================================
-- 1. 主标题
local panelTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
panelTitle:SetPoint("TOPLEFT", 16, -16)
panelTitle:SetText("SuperIgnore v" .. (addonVersion or "未知版本"))

-- 2. 新增简介文字 (第一行)
local panelDesc1 = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
panelDesc1:SetPoint("TOPLEFT", panelTitle, "BOTTOMLEFT", 0, -10)
panelDesc1:SetText("SuperIgnore (超级黑名单) 是一款极简、轻量、高性能的聊天过滤与黑名单管理插件。")

-- 3. 新增简介文字 (第二行)
local panelDesc2 = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
panelDesc2:SetPoint("TOPLEFT", panelDesc1, "BOTTOMLEFT", 0, -6)
panelDesc2:SetText("一次拉黑，全战网所有角色共同生效，还你清净的艾泽拉斯！")

local currentMode = "PLAYER" 

-- ==========================================
-- 顶部页签按钮
-- ==========================================
local btnPlayers = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnPlayers:SetSize(100, 25)

btnPlayers:SetPoint("TOPLEFT", 16, -95)
btnPlayers:SetText("屏蔽玩家")

local btnKeywords = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnKeywords:SetSize(100, 25)
btnKeywords:SetPoint("LEFT", btnPlayers, "RIGHT", 10, 0)
btnKeywords:SetText("屏蔽关键词")

local btnData = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnData:SetSize(100, 25)
btnData:SetPoint("LEFT", btnKeywords, "RIGHT", 10, 0)
btnData:SetText("数据/同步")

-- 【新增】：“关于”按钮
local btnAbout = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAbout:SetSize(80, 25)
btnAbout:SetPoint("LEFT", btnData, "RIGHT", 10, 0)
btnAbout:SetText("关于")

-- ==========================================
-- 玩家模式组件
-- ==========================================
local addPlayerNameBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addPlayerNameBox:SetSize(130, 30)
addPlayerNameBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 5, -35)
addPlayerNameBox:SetAutoFocus(false)
addPlayerNameBox.title = addPlayerNameBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addPlayerNameBox.title:SetPoint("BOTTOMLEFT", addPlayerNameBox, "TOPLEFT", 0, 5)
addPlayerNameBox.title:SetText("玩家-服务器:")

local addPlayerReasonBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addPlayerReasonBox:SetSize(100, 30)
addPlayerReasonBox:SetPoint("LEFT", addPlayerNameBox, "RIGHT", 15, 0)
addPlayerReasonBox:SetAutoFocus(false)
addPlayerReasonBox.title = addPlayerReasonBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addPlayerReasonBox.title:SetPoint("BOTTOMLEFT", addPlayerReasonBox, "TOPLEFT", 0, 5)
addPlayerReasonBox.title:SetText("备注:")

local quickBtns = {}
local reasons = {"代练", "广告", "喷子", "SB"}
for i, r in ipairs(reasons) do
    local btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    btn:SetSize(40, 22)
    if i == 1 then
        btn:SetPoint("LEFT", addPlayerReasonBox, "RIGHT", 5, 0)
    else
        btn:SetPoint("LEFT", quickBtns[i-1], "RIGHT", 2, 0)
    end
    btn:SetText(r)
    btn:SetScript("OnClick", function() addPlayerReasonBox:SetText(r) end)
    quickBtns[i] = btn
end

local btnAddPlayer = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAddPlayer:SetSize(60, 25)
btnAddPlayer:SetPoint("LEFT", quickBtns[#quickBtns], "RIGHT", 10, 0)
btnAddPlayer:SetText("添加")

-- ==========================================
-- 关键词模式组件
-- ==========================================
local addWordBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addWordBox:SetSize(180, 30)
addWordBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 5, -35)
addWordBox:SetAutoFocus(false)
addWordBox.title = addWordBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addWordBox.title:SetPoint("BOTTOMLEFT", addWordBox, "TOPLEFT", 0, 5)
addWordBox.title:SetText("新增屏蔽词 (支持正则):")

local btnAddWord = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAddWord:SetSize(60, 25)
btnAddWord:SetPoint("LEFT", addWordBox, "RIGHT", 10, 0)
btnAddWord:SetText("添加")

-- ==========================================
-- 列表 UI 组件 (服务于玩家和关键词模式)
-- ==========================================
local searchBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
searchBox:SetSize(200, 30)

searchBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 45, -90)
searchBox:SetAutoFocus(false)

searchBox.title = searchBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")

searchBox.title:SetPoint("RIGHT", searchBox, "LEFT", -5, 0)
searchBox.title:SetText("搜索:")

local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")

scrollFrame:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -5, -10)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 20)

local scrollChild = CreateFrame("Frame", nil, scrollFrame)
scrollChild:SetSize(550, 1) 
scrollFrame:SetScrollChild(scrollChild)

local rows = {}

-- ==========================================
-- 导入/导出 UI 组件
-- ==========================================
local dataFrame = CreateFrame("Frame", nil, panel)
dataFrame:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 0, -20)
dataFrame:SetPoint("BOTTOMRIGHT", -30, 20)
dataFrame:Hide()

local btnGenerate = CreateFrame("Button", nil, dataFrame, "UIPanelButtonTemplate")
btnGenerate:SetSize(120, 25)
btnGenerate:SetPoint("TOPLEFT", 5, 0)
btnGenerate:SetText("生成导出代码")

local btnImportData = CreateFrame("Button", nil, dataFrame, "UIPanelButtonTemplate")
btnImportData:SetSize(130, 25)
btnImportData:SetPoint("LEFT", btnGenerate, "RIGHT", 20, 0)
btnImportData:SetText("导入并覆盖合并")

-- 【新增】：集合石同步按钮
local btnSyncMS = CreateFrame("Button", nil, dataFrame, "UIPanelButtonTemplate")
btnSyncMS:SetSize(160, 25)
-- 定位在“导入并覆盖合并”按钮的右侧
btnSyncMS:SetPoint("LEFT", btnImportData, "RIGHT", 20, 0) 
btnSyncMS:SetText("同步集合石屏蔽列表")

-- 【新增】：自动同步复选框
local chkAutoSync = CreateFrame("CheckButton", nil, dataFrame, "InterfaceOptionsCheckButtonTemplate")
-- 将它定位在“同步集合石列表”按钮的右侧
chkAutoSync:SetPoint("LEFT", btnSyncMS, "RIGHT", 15, 0)
chkAutoSync.Text:SetText("打开面板自动同步")
chkAutoSync.Text:SetFontObject("GameFontHighlightSmall")

-- 点击复选框时，保存状态到数据库
chkAutoSync:SetScript("OnClick", function(self)
    SuperIgnoreDB = SuperIgnoreDB or {}
    SuperIgnoreDB["__CONFIG_AUTOSYNC__"] = self:GetChecked()
end)



-- 【新增】：数据统计显示文本
local dataStatsText = dataFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
-- 定位在代码框的左上角，三个按钮的下方
dataStatsText:SetPoint("TOPLEFT", btnGenerate, "BOTTOMLEFT", 5, -8)

local dataScroll = CreateFrame("ScrollFrame", nil, dataFrame, "UIPanelScrollFrameTemplate")

dataScroll:SetPoint("TOPLEFT", btnGenerate, "BOTTOMLEFT", 0, -25)
dataScroll:SetPoint("BOTTOMRIGHT", 0, 0)

-- 使用原生底板使其看起来像个真正的代码框
local dataBackdrop = CreateFrame("Frame", nil, dataScroll, "TooltipBackdropTemplate")
dataBackdrop:SetPoint("TOPLEFT", -5, 5)
dataBackdrop:SetPoint("BOTTOMRIGHT", 25, -5)
dataBackdrop:SetFrameLevel(dataScroll:GetFrameLevel() - 1)

local dataEditBox = CreateFrame("EditBox", nil, dataScroll)
dataEditBox:SetMultiLine(true)
dataEditBox:SetFontObject("ChatFontNormal")
dataEditBox:SetWidth(520)
dataEditBox:SetAutoFocus(false)
dataScroll:SetScrollChild(dataEditBox)


-- ==========================================
-- 关于 (About) UI 组件
-- ==========================================
local aboutFrame = CreateFrame("Frame", nil, panel)
aboutFrame:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 0, -20)
aboutFrame:SetPoint("BOTTOMRIGHT", -30, 20)
aboutFrame:Hide()

-- 作者与版本信息
local aboutTitle = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
aboutTitle:SetPoint("TOPLEFT", 10, -10)
aboutTitle:SetText("SuperIgnore (超级黑名单)")

local aboutAuthor = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
aboutAuthor:SetPoint("TOPLEFT", aboutTitle, "BOTTOMLEFT", 0, -15)
aboutAuthor:SetText("作者: okqiyi \n" ..
                    "版本: v1.1.0\n\n" ..
                    "【v1.1.0 核心更新】\n" ..
                    "- 新增自动同步网易集合石黑名单功能。\n" ..
                    "- 优化底层数据清洗逻辑，提升跨服匹配精度。\n\n" ..
                    "如果遇到 Bug 或有功能建议，欢迎在 NGA 原创插件区反馈！")
aboutAuthor:SetJustifyH("LEFT") 


-- ==========================================
-- 【新增】NGA 帖子链接
-- ==========================================
local ngaTitle = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")

ngaTitle:SetPoint("TOPLEFT", aboutAuthor, "BOTTOMLEFT", 0, -20)
ngaTitle:SetText("NGA  (请按 Ctrl+C 复制):")

local ngaBox = CreateFrame("EditBox", nil, aboutFrame, "InputBoxTemplate")
ngaBox:SetSize(420, 30)
ngaBox:SetPoint("TOPLEFT", ngaTitle, "BOTTOMLEFT", 5, -5)
ngaBox:SetAutoFocus(false)
ngaBox:SetText("https://bbs.nga.cn/read.php?tid=47106371")
ngaBox:SetCursorPosition(0)
-- 阻止玩家修改网址
ngaBox:SetScript("OnTextChanged", function(self)
    if self:GetText() ~= "https://bbs.nga.cn/read.php?tid=47106371" then
        self:SetText("https://bbs.nga.cn/read.php?tid=47106371")
    end
end)


-- ==========================================
-- CurseForge 下载链接
-- ==========================================
local urlTitle = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")

urlTitle:SetPoint("TOPLEFT", ngaBox, "BOTTOMLEFT", -5, -15)
urlTitle:SetText("CurseForge  (请按 Ctrl+C 复制):")

local urlBox = CreateFrame("EditBox", nil, aboutFrame, "InputBoxTemplate")
urlBox:SetSize(420, 30)
urlBox:SetPoint("TOPLEFT", urlTitle, "BOTTOMLEFT", 5, -5)
urlBox:SetAutoFocus(false)
urlBox:SetText("https://www.curseforge.com/wow/addons/superignore")
urlBox:SetCursorPosition(0)
-- 阻止玩家修改网址
urlBox:SetScript("OnTextChanged", function(self)
    if self:GetText() ~= "https://www.curseforge.com/wow/addons/superignore" then
        self:SetText("https://www.curseforge.com/wow/addons/superignore")
    end
end)


-- ==========================================
-- 核心刷新与界面切换逻辑
-- ==========================================
local function RefreshList()
    -- 隐藏所有面板组件
    addPlayerNameBox:Hide(); addPlayerReasonBox:Hide(); btnAddPlayer:Hide()
    for _, b in ipairs(quickBtns) do b:Hide() end
    addWordBox:Hide(); btnAddWord:Hide()
    dataFrame:Hide()
	aboutFrame:Hide()
    
    btnPlayers:UnlockHighlight()
    btnKeywords:UnlockHighlight()
    btnData:UnlockHighlight()
	btnAbout:UnlockHighlight()

    -- 根据当前模式展示对应的组件
    if currentMode == "PLAYER" then
        btnPlayers:LockHighlight()
        addPlayerNameBox:Show(); addPlayerReasonBox:Show(); btnAddPlayer:Show()
        for _, b in ipairs(quickBtns) do b:Show() end
        
    elseif currentMode == "KEYWORD" then
        btnKeywords:LockHighlight()
        addWordBox:Show(); btnAddWord:Show()
        
    elseif currentMode == "DATA" then
        btnData:LockHighlight()
        dataFrame:Show()
        aboutFrame:Hide()
        
        -- 让自动同步默认打勾。只有明确被玩家关掉 (false) 时才取消勾选
        if SuperIgnoreDB and SuperIgnoreDB["__CONFIG_AUTOSYNC__"] == false then
            chkAutoSync:SetChecked(false)
        else
            chkAutoSync:SetChecked(true)
        end
        
        -- 数据统计逻辑
        local pCount, kCount = 0, 0
        for _ in pairs(SuperIgnoreDB or {}) do pCount = pCount + 1 end
        for _ in pairs(SuperIgnoreKeywordsDB or {}) do kCount = kCount + 1 end
        if dataStatsText then
            dataStatsText:SetText(string.format("当前统计：已拦截玩家 %d 名，屏蔽关键词 %d 个", pCount, kCount))
        end
        
        searchBox:Hide(); scrollFrame:Hide()
        return 
        
    elseif currentMode == "ABOUT" then
        btnAbout:LockHighlight()
        aboutFrame:Show()
        dataFrame:Hide() 
        
        searchBox:Hide(); scrollFrame:Hide()
        return
    end
    
    -- 确保切回 PLAYER 或 KEYWORD 时，搜索框能正常显示
    if currentMode ~= "DATA" and currentMode ~= "ABOUT" then
        searchBox:Show(); scrollFrame:Show()
    end
			
	

    -- 渲染列表逻辑
    local filter = searchBox:GetText():lower()
    for _, row in ipairs(rows) do row:Hide() end
    
    local yOffset = 0
    local rowIndex = 1
    local targetDB = (currentMode == "PLAYER") and SuperIgnoreDB or SuperIgnoreKeywordsDB
    local myRealm = GetNormalizedRealmName()

    if targetDB then
        for key, data in pairs(targetDB) do
            local displayKey = key
            local subText = ""

            if currentMode == "PLAYER" then
                local reason = data.reason or "无"
                local timeStr = data.time or ""
                subText = reason .. " (" .. timeStr .. ")"
                if not displayKey:find("-") then displayKey = displayKey .. "-" .. myRealm end
            else
                subText = "添加时间: " .. tostring(data)
            end

            if filter == "" or displayKey:lower():find(filter) or subText:lower():find(filter) then
                local row = rows[rowIndex]
                if not row then
                    row = CreateFrame("Frame", nil, scrollChild)
                    row:SetSize(550, 30) 
                    
                    row.nameText = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
                    row.nameText:SetPoint("LEFT", 5, 0)
                    row.nameText:SetWidth(180)
                    row.nameText:SetJustifyH("LEFT")
                    row.nameText:SetTextColor(1, 0.8, 0)
                    
                    row.reasonText = row:CreateFontString(nil, "ARTWORK", "GameFontDisable")
                    row.reasonText:SetPoint("LEFT", row.nameText, "RIGHT", 10, 0)
                    row.reasonText:SetWidth(250)
                    row.reasonText:SetJustifyH("LEFT")
                    
                    row.removeBtn = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
                    row.removeBtn:SetSize(60, 22)
                    row.removeBtn:SetPoint("RIGHT", row, "RIGHT", -10, 0)
                    row.removeBtn:SetText("移除")
                    
                    rows[rowIndex] = row
                end
                
                row.nameText:SetText(displayKey)
                row.reasonText:SetText(subText)
                
                row.removeBtn:SetScript("OnClick", function()
                    targetDB[key] = nil
                    
                    RefreshList()
                end)
                
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -yOffset)
                row:Show()
                
                yOffset = yOffset + 30
                rowIndex = rowIndex + 1
            end
        end
    end
    scrollChild:SetHeight(math.max(yOffset + 10, 1))
end

-- ==========================================
-- 绑定点击与输入事件
-- ==========================================
btnPlayers:SetScript("OnClick", function() currentMode = "PLAYER"; RefreshList() end)
btnKeywords:SetScript("OnClick", function() currentMode = "KEYWORD"; RefreshList() end)
btnData:SetScript("OnClick", function() currentMode = "DATA"; RefreshList() end)
btnAbout:SetScript("OnClick", function() currentMode = "ABOUT"; RefreshList() end) 


-- 手动添加玩家事件 (恢复自动补全与防呆清理)
btnAddPlayer:SetScript("OnClick", function()
    local name = addPlayerNameBox:GetText()
    if not name or name == "" then return end
    
    -- 清理复制粘贴时可能带入的首尾空格
    name = string.match(name, "^%s*(.-)%s*$")
    
    -- 【核心修复】：如果发现名字没带 "-", 自动拿当前服务器补全
    if not string.find(name, "-") then
        local myRealm = GetNormalizedRealmName() or ""
        if myRealm ~= "" then
            name = name .. "-" .. myRealm
        end
    end
    
    -- 终极防呆：如果系统抽风没取到服务器，再进行红字拦截
    if not string.find(name, "-") then
        print("|cffff0000[SuperIgnore]|r 错误：必须输入包含服务器的完整名字（如：张三-燃烧之刃）！")
        return
    end
    
    local reason = addPlayerReasonBox:GetText()
    if reason == "" then reason = "手动添加" end
    
    SuperIgnoreDB[name] = {reason = reason, time = date("%Y-%m-%d %H:%M")}
    -- 这里已经清除了引发报错的 SaveVariables
    
    addPlayerNameBox:SetText("")
    addPlayerReasonBox:SetText("")
    RefreshList()
    print("|cffff0000[SuperIgnore]|r 已拉黑：" .. name)
end)

btnAddWord:SetScript("OnClick", function()
    local word = addWordBox:GetText()
    if word and word ~= "" then
        SuperIgnoreKeywordsDB[word] = date("%Y-%m-%d %H:%M")
        
        addWordBox:SetText("")
        RefreshList()
        print("|cffff0000[SuperIgnore]|r 已添加屏蔽词：" .. word)
    end
end)



-- 生成导出数据 
btnGenerate:SetScript("OnClick", function()
    local lines = {"--SuperIgnoreDataV1"}
    
    for k, v in pairs(SuperIgnoreDB or {}) do
        -- 数据库里存的是什么标准格式，就原封不动地导出什么
        table.insert(lines, "P^" .. k .. "^" .. (v.reason or "") .. "^" .. (v.time or ""))
    end
    
    for k, v in pairs(SuperIgnoreKeywordsDB or {}) do
        table.insert(lines, "K^" .. k .. "^" .. tostring(v))
    end
    
    dataEditBox:SetText(table.concat(lines, "\n"))
    dataEditBox:HighlightText()
    print("|cffff0000[SuperIgnore]|r 代码已生成，请按 Ctrl+C 复制。")
end)


-- 导入解析数据 (脏数据清洗模式)
btnImportData:SetScript("OnClick", function()
    local str = dataEditBox:GetText()
    
    if not str or str == "" then return end
    if not string.find(str, "--SuperIgnoreDataV1", 1, true) then
        print("|cffff0000[SuperIgnore]|r 数据格式不对！请确保包含了 --SuperIgnoreDataV1")
        return
    end
    
    local pCount, kCount = 0, 0
    local skipCount = 0 -- 记录被清洗掉的无效数据
    
    for line in str:gmatch("[^\r\n]+") do
        line = string.match(line, "^%s*(.-)%s*$")
        if line and line ~= "" and string.sub(line, 1, 2) ~= "--" then
            -- ... (中间的字符串拆解逻辑保持不变，直到执行存入的部分) ...
            local typeTag, nameOrWord, reason, time = "", "", "", ""
            
            local i1 = string.find(line, "%^")
            if i1 then
                typeTag = string.sub(line, 1, i1 - 1)
                local remaining = string.sub(line, i1 + 1)
                local i2 = string.find(remaining, "%^")
                if i2 then
                    nameOrWord = string.sub(remaining, 1, i2 - 1)
                    local rest2 = string.sub(remaining, i2 + 1)
                    local i3 = string.find(rest2, "%^")
                    if i3 then
                        reason = string.sub(rest2, 1, i3 - 1)
                        time = string.sub(rest2, i3 + 1)
                    else
                        reason = rest2
                    end
                else
                    nameOrWord = remaining
                end
            end
            
            -- 【核心清洗逻辑】：执行存入前进行铁血安检
            if typeTag == "P" and nameOrWord ~= "" then
                if string.find(nameOrWord, "-") then
                    SuperIgnoreDB = SuperIgnoreDB or {}
                    SuperIgnoreDB[nameOrWord] = { reason = reason ~= "" and reason or "导入", time = time ~= "" and time or date("%Y-%m-%d %H:%M") }
                    pCount = pCount + 1
                else
                    skipCount = skipCount + 1
                end
            elseif typeTag == "K" and nameOrWord ~= "" then
                SuperIgnoreKeywordsDB = SuperIgnoreKeywordsDB or {}
                SuperIgnoreKeywordsDB[nameOrWord] = time ~= "" and time or date("%Y-%m-%d %H:%M")
                kCount = kCount + 1
            end
        end
    end 

    local msg = string.format("|cff00ff00[SuperIgnore]|r 导入合并完成。新增: 玩家%d, 关键词%d", pCount, kCount)
    if skipCount > 0 then
        msg = msg .. string.format("。|cffffff00已自动过滤 %d 条无服务器的无效数据。|r", skipCount)
    end
    print(msg)
    
    dataEditBox:SetText("")
    pcall(RefreshList)
end) 

-- ==========================================
-- 核心逻辑：执行集合石同步
-- ==========================================
-- 参数 isAuto: 如果为 true，代表是系统自动触发的，不需要在没抓到人时报黄字打扰玩家
local function DoSyncMeetingStone(isAuto)
    if not MEETINGSTONE_UI_DB or not MEETINGSTONE_UI_DB.global or not MEETINGSTONE_UI_DB.global.UIMemory or not MEETINGSTONE_UI_DB.global.UIMemory.IGNORE_LIST then
        if not isAuto then
            print("|cffff0000[SuperIgnore]|r 未检测到网易集合石插件，或当前没有集合石屏蔽数据。")
        end
        return
    end

    local msList = MEETINGSTONE_UI_DB.global.UIMemory.IGNORE_LIST
    local count = 0
    SuperIgnoreDB = SuperIgnoreDB or {}

    for _, data in ipairs(msList) do
        local name = data.leader
        local reason = data.dep or "集合石同步"
        local timeStr = data.time or date("%Y-%m-%d %H:%M")

        if name and name ~= "" and string.find(name, "-") and not SuperIgnoreDB[name] then
            SuperIgnoreDB[name] = { reason = reason, time = timeStr }
            count = count + 1
        end
    end

    if count > 0 then
        print("|cff00ff00[SuperIgnore]|r 集合石自动同步触发！已静默抓取 " .. count .. " 名新名单加入通用黑名单。")
        if RefreshList then RefreshList() end
    else
        -- 只有玩家手动点击按钮时，如果没有新数据，才提示黄字
        if not isAuto then
            print("|cffffff00[SuperIgnore]|r 集合石列表已全部同步过，没有发现新的黑名单。")
        end
    end
end

-- 绑定手动同步按钮
btnSyncMS:SetScript("OnClick", function() 
    DoSyncMeetingStone(false) -- 手动点击，isAuto = false
end)


searchBox:SetScript("OnTextChanged", RefreshList)

-- 面板显示事件
panel:SetScript("OnShow", function()
    -- 【修改】：只要不是明确手动关掉的 (false)，就默认执行静默同步
    if SuperIgnoreDB and SuperIgnoreDB["__CONFIG_AUTOSYNC__"] ~= false then
        if DoSyncMeetingStone then 
            DoSyncMeetingStone(true) 
        end
    end
    RefreshList()
end)

if Settings and Settings.RegisterCanvasLayoutCategory then
    local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(category)
    SuperIgnoreCategory = category
end