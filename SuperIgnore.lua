-- SuperIgnore v1.2.0
-- A lightweight, account-wide ignore list management tool.
-- Copyright (c) 2026 okqiyi. All rights reserved.

-- ==========================================
-- 0. 多语言字典 (Localization)
-- ==========================================
local L = {
    -- [Default: English]
    UI_ADD_TITLE = "Add to SuperIgnore",
    UI_TARGET_NONE = "Target: None",
    UI_TARGET_PREFIX = "Target: |cff00ff00",
    UI_BTN_CONFIRM = "Confirm",
    UI_BTN_CANCEL = "Cancel",
    
    BTN_R1 = "Boosting",
    BTN_R2 = "Ad",
    BTN_R3 = "Toxic",
    BTN_R4 = "Bot",
    
    MENU_ADD = "Add to SuperIgnore",
    REASON_MANUAL = "Manual Add",
    REASON_IMPORT = "Imported",
    REASON_MS = "MeetingStone Sync",
    UNKNOWN_VERSION = "Unknown Version",
    
    PANEL_DESC1 = "SuperIgnore is a lightweight, high-performance chat filtering & ignore list addon.",
    PANEL_DESC2 = "Account-wide ignore. Block once, clean chat on all characters!",
    
    TAB_PLAYER = "Block Player",
    TAB_KEYWORD = "Block Keyword",
    TAB_DATA = "Data/Sync",
    TAB_ABOUT = "About",
    
    UI_PLAYER_INPUT = "Player-Realm:",
    UI_REASON_INPUT = "Note:",
    UI_BTN_ADD = "Add",
    UI_KEYWORD_INPUT = "New Keyword (Regex):",
    
    UI_SEARCH = "Search:",
    UI_BTN_EXPORT = "Export Data",
    UI_BTN_IMPORT = "Import & Merge",
    UI_BTN_SYNC = "Sync MeetingStone",
    UI_CHK_AUTOSYNC = "Auto-sync on panel open",
    
    STATS_TEXT = "Stats: %d Players blocked, %d Keywords blocked",
    ABOUT_TITLE = "SuperIgnore",
    ABOUT_TEXT = "Author: okqiyi \nVersion: v1.2.0\n\n【v1.2.0 Updates】\n- Added multi-language support (EN, zhCN, zhTW).\n- Optimized cross-realm detection.\n\nFeedback is welcome on CurseForge or NGA!",
    ABOUT_NGA = "NGA (Ctrl+C to copy):",
    ABOUT_CF = "CurseForge (Ctrl+C to copy):",
    
    LIST_REASON_NONE = "None",
    LIST_ADD_TIME = "Added: ",
    LIST_BTN_REMOVE = "Remove",
    
    -- Chat Messages
    MSG_GROUP_DECLINED = "|cffff0000[SuperIgnore]|r Auto-declined group invite from blocked player %s.",
    MSG_TRADE_DECLINED = "|cffff0000[SuperIgnore]|r Auto-declined trade request from blocked player %s.",
    MSG_BLACKLISTED = "|cffff0000[SuperIgnore]|r Blocked %s. Reason: %s",
    MSG_ADDED_KEYWORD = "|cffff0000[SuperIgnore]|r Added keyword: %s",
    MSG_EXPORTED = "|cffff0000[SuperIgnore]|r Code generated. Press Ctrl+C to copy.",
    MSG_IMPORT_SUCCESS = "|cff00ff00[SuperIgnore]|r Import complete. Added: %d Players, %d Keywords.",
    MSG_IMPORT_FILTERED = " |cffffff00Auto-filtered %d invalid entries without realm.|r",
    MSG_MS_SUCCESS = "|cff00ff00[SuperIgnore]|r Auto-sync triggered! Silently added %d new players to global list.",
    
    -- Error Messages
    MSG_ERR_NO_REALM = "|cffff0000[SuperIgnore]|r Failed to get realm info, block failed!",
    MSG_ERR_COMBAT = "|cffff0000[SuperIgnore]|r Cannot open settings in combat.",
    MSG_ERR_NO_PANEL = "|cffff0000[SuperIgnore]|r Error: Settings panel not initialized.",
    MSG_ERR_FORMAT = "|cffff0000[SuperIgnore]|r Error: Must include realm name (e.g., Player-Realm)!",
    MSG_ERR_IMPORT = "|cffff0000[SuperIgnore]|r Invalid format! Must include --SuperIgnoreDataV1",
    MSG_ERR_NO_MS = "|cffff0000[SuperIgnore]|r MeetingStone addon not found or list empty.",
    MSG_MS_EMPTY = "|cffffff00[SuperIgnore]|r MeetingStone list already synced. No new players found."
}

local locale = GetLocale()
if locale == "zhCN" then
    L.UI_ADD_TITLE = "添加超级黑名单"
    L.UI_TARGET_NONE = "目标：无"
    L.UI_TARGET_PREFIX = "目标：|cff00ff00"
    L.UI_BTN_CONFIRM = "确认"
    L.UI_BTN_CANCEL = "取消"
    L.BTN_R1 = "代练"
    L.BTN_R2 = "广告"
    L.BTN_R3 = "喷子"
    L.BTN_R4 = "SB"
    L.MENU_ADD = "加入超级黑名单"
    L.REASON_MANUAL = "手动添加"
    L.REASON_IMPORT = "导入"
    L.REASON_MS = "集合石同步"
    L.UNKNOWN_VERSION = "未知版本"
    L.PANEL_DESC1 = "SuperIgnore (超级黑名单) 是一款极简、轻量、高性能的聊天过滤与黑名单管理插件。"
    L.PANEL_DESC2 = "一次拉黑，全战网所有角色共同生效，还你清净的艾泽拉斯！"
    L.TAB_PLAYER = "屏蔽玩家"
    L.TAB_KEYWORD = "屏蔽关键词"
    L.TAB_DATA = "数据/同步"
    L.TAB_ABOUT = "关于"
    L.UI_PLAYER_INPUT = "玩家-服务器:"
    L.UI_REASON_INPUT = "备注:"
    L.UI_BTN_ADD = "添加"
    L.UI_KEYWORD_INPUT = "新增屏蔽词 (支持正则):"
    L.UI_SEARCH = "搜索:"
    L.UI_BTN_EXPORT = "生成导出代码"
    L.UI_BTN_IMPORT = "导入并覆盖合并"
    L.UI_BTN_SYNC = "同步集合石屏蔽列表"
    L.UI_CHK_AUTOSYNC = "打开面板自动同步"
    L.STATS_TEXT = "当前统计：已拦截玩家 %d 名，屏蔽关键词 %d 个"
    L.ABOUT_TITLE = "SuperIgnore (超级黑名单)"
    L.ABOUT_TEXT = "作者: okqiyi \n版本: v1.2.0\n\n【v1.2.0 核心更新】\n- 全面支持多语言 (简中/繁中/英文)。\n- 优化底层数据清洗逻辑，提升跨服匹配精度。\n\n如果遇到 Bug 或有功能建议，欢迎在 NGA 原创插件区反馈！"
    L.ABOUT_NGA = "NGA  (请按 Ctrl+C 复制):"
    L.ABOUT_CF = "CurseForge  (请按 Ctrl+C 复制):"
    L.LIST_REASON_NONE = "无"
    L.LIST_ADD_TIME = "添加时间: "
    L.LIST_BTN_REMOVE = "移除"
    
    L.MSG_GROUP_DECLINED = "|cffff0000[SuperIgnore]|r 已自动拒绝黑名单玩家 %s 的组队邀请。"
    L.MSG_TRADE_DECLINED = "|cffff0000[SuperIgnore]|r 已自动拒绝黑名单玩家 %s 的交易请求。"
    L.MSG_BLACKLISTED = "|cffff0000[SuperIgnore]|r 已拉黑 %s。原因：%s"
    L.MSG_ADDED_KEYWORD = "|cffff0000[SuperIgnore]|r 已添加屏蔽词：%s"
    L.MSG_EXPORTED = "|cffff0000[SuperIgnore]|r 代码已生成，请按 Ctrl+C 复制。"
    L.MSG_IMPORT_SUCCESS = "|cff00ff00[SuperIgnore]|r 导入合并完成。新增: 玩家%d, 关键词%d"
    L.MSG_IMPORT_FILTERED = "。|cffffff00已自动过滤 %d 条无服务器的无效数据。|r"
    L.MSG_MS_SUCCESS = "|cff00ff00[SuperIgnore]|r 集合石自动同步触发！已静默抓取 %d 名新名单加入通用黑名单。"
    
    L.MSG_ERR_NO_REALM = "|cffff0000[SuperIgnore]|r 无法获取该玩家的服务器信息，拉黑失败！"
    L.MSG_ERR_COMBAT = "|cffff0000[SuperIgnore]|r 战斗中系统限制，无法打开设置面板，请脱战后再试。"
    L.MSG_ERR_NO_PANEL = "|cffff0000[SuperIgnore]|r 错误：设置面板未初始化。"
    L.MSG_ERR_FORMAT = "|cffff0000[SuperIgnore]|r 错误：必须输入包含服务器的完整名字（如：张三-燃烧之刃）！"
    L.MSG_ERR_IMPORT = "|cffff0000[SuperIgnore]|r 数据格式不对！请确保包含了 --SuperIgnoreDataV1"
    L.MSG_ERR_NO_MS = "|cffff0000[SuperIgnore]|r 未检测到网易集合石插件，或当前没有集合石屏蔽数据。"
    L.MSG_MS_EMPTY = "|cffffff00[SuperIgnore]|r 集合石列表已全部同步过，没有发现新的黑名单。"

elseif locale == "zhTW" then
    L.UI_ADD_TITLE = "加入超級黑名單"
    L.UI_TARGET_NONE = "目標：無"
    L.UI_TARGET_PREFIX = "目標：|cff00ff00"
    L.UI_BTN_CONFIRM = "確認"
    L.UI_BTN_CANCEL = "取消"
    L.BTN_R1 = "代打"
    L.BTN_R2 = "廣告"
    L.BTN_R3 = "屁孩"
    L.BTN_R4 = "外掛"
    L.MENU_ADD = "加入超級黑名單"
    L.REASON_MANUAL = "手動加入"
    L.REASON_IMPORT = "匯入"
    L.REASON_MS = "集合石同步"
    L.UNKNOWN_VERSION = "未知版本"
    L.PANEL_DESC1 = "SuperIgnore (超級黑名單) 是一款極簡、輕量、高效能的聊天過濾與黑名單管理插件。"
    L.PANEL_DESC2 = "一次黑單，全戰網所有角色共同生效，還你清淨的艾澤拉斯！"
    L.TAB_PLAYER = "封鎖玩家"
    L.TAB_KEYWORD = "封鎖關鍵字"
    L.TAB_DATA = "資料/同步"
    L.TAB_ABOUT = "關於"
    L.UI_PLAYER_INPUT = "玩家-伺服器:"
    L.UI_REASON_INPUT = "備註:"
    L.UI_BTN_ADD = "加入"
    L.UI_KEYWORD_INPUT = "新增封鎖詞 (支援正則):"
    L.UI_SEARCH = "搜尋:"
    L.UI_BTN_EXPORT = "產生匯出代碼"
    L.UI_BTN_IMPORT = "匯入並覆蓋合併"
    L.UI_BTN_SYNC = "同步集合石黑名單"
    L.UI_CHK_AUTOSYNC = "開啟面板自動同步"
    L.STATS_TEXT = "當前統計：已攔截玩家 %d 名，封鎖關鍵字 %d 個"
    L.ABOUT_TITLE = "SuperIgnore (超級黑名單)"
    L.ABOUT_TEXT = "作者: okqiyi \n版本: v1.2.0\n\n【v1.2.0 核心更新】\n- 全面支援多國語言 (簡中/繁中/英文)。\n- 優化底層資料清洗邏輯，提升跨服匹配精度。\n\n如果有任何 Bug 或建議，歡迎到 CurseForge 反饋！"
    L.ABOUT_NGA = "NGA (請按 Ctrl+C 複製):"
    L.ABOUT_CF = "CurseForge (請按 Ctrl+C 複製):"
    L.LIST_REASON_NONE = "無"
    L.LIST_ADD_TIME = "加入時間: "
    L.LIST_BTN_REMOVE = "移除"
    
    L.MSG_GROUP_DECLINED = "|cffff0000[SuperIgnore]|r 已自動拒絕黑名單玩家 %s 的組隊邀請。"
    L.MSG_TRADE_DECLINED = "|cffff0000[SuperIgnore]|r 已自動拒絕黑名單玩家 %s 的交易請求。"
    L.MSG_BLACKLISTED = "|cffff0000[SuperIgnore]|r 已封鎖 %s。原因：%s"
    L.MSG_ADDED_KEYWORD = "|cffff0000[SuperIgnore]|r 已加入封鎖詞：%s"
    L.MSG_EXPORTED = "|cffff0000[SuperIgnore]|r 代碼已產生，請按 Ctrl+C 複製。"
    L.MSG_IMPORT_SUCCESS = "|cff00ff00[SuperIgnore]|r 匯入合併完成。新增: 玩家%d, 關鍵字%d"
    L.MSG_IMPORT_FILTERED = "。|cffffff00已自動過濾 %d 筆無伺服器的無效資料。|r"
    L.MSG_MS_SUCCESS = "|cff00ff00[SuperIgnore]|r 集合石自動同步觸發！已靜默抓取 %d 名新名單加入通用黑名單。"
    
    L.MSG_ERR_NO_REALM = "|cffff0000[SuperIgnore]|r 無法獲取該玩家的伺服器資訊，封鎖失敗！"
    L.MSG_ERR_COMBAT = "|cffff0000[SuperIgnore]|r 戰鬥中系統限制，無法開啟設定面板，請脫戰後再試。"
    L.MSG_ERR_NO_PANEL = "|cffff0000[SuperIgnore]|r 錯誤：設定面板未初始化。"
    L.MSG_ERR_FORMAT = "|cffff0000[SuperIgnore]|r 錯誤：必須輸入包含伺服器的完整名字（如：張三-燃燒之刃）！"
    L.MSG_ERR_IMPORT = "|cffff0000[SuperIgnore]|r 資料格式錯誤！請確保包含了 --SuperIgnoreDataV1"
    L.MSG_ERR_NO_MS = "|cffff0000[SuperIgnore]|r 未偵測到網易集合石插件，或目前沒有集合石黑名單資料。"
    L.MSG_MS_EMPTY = "|cffffff00[SuperIgnore]|r 集合石列表已全部同步過，沒有發現新的黑名單。"
end

-- 1. 初始化数据库
SuperIgnoreDB = SuperIgnoreDB or {}
SuperIgnoreKeywordsDB = SuperIgnoreKeywordsDB or {}

-- 2. 聊天过滤模块：屏蔽喊话和私聊
local function ChatFilter(self, event, msg, author, ...)
    if SuperIgnoreKeywordsDB then
        for keyword, _ in pairs(SuperIgnoreKeywordsDB) do
            if msg:find(keyword) then
                return true
            end
        end
    end
    
    local name, realm = strsplit("-", author)
    if not realm or realm == "" then
        realm = GetNormalizedRealmName()
    end
    
    local fullName = name .. "-" .. realm
    if SuperIgnoreDB[fullName] or SuperIgnoreDB[author] then
        return true 
    end
    
    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilter)

-- 3. 组队与交易拦截模块
local frame = CreateFrame("Frame")
frame:RegisterEvent("PARTY_INVITE_REQUEST")
frame:RegisterEvent("TRADE_REQUEST")
frame:SetScript("OnEvent", function(self, event, sender, ...)
    if event == "PARTY_INVITE_REQUEST" then
        local cleanSender = Ambiguate(sender, "none")
        if SuperIgnoreDB[sender] or SuperIgnoreDB[cleanSender] then
            DeclineGroup()
            StaticPopup_Hide("PARTY_INVITE")
            print(string.format(L.MSG_GROUP_DECLINED, sender))
        end
    elseif event == "TRADE_REQUEST" then
        local cleanSender = Ambiguate(sender, "none")
        if SuperIgnoreDB[sender] or SuperIgnoreDB[cleanSender] then
            CancelTrade()
            print(string.format(L.MSG_TRADE_DECLINED, sender))
        end
    end
end)


-- 4. 独立 UI 窗口
local f = CreateFrame("Frame", "SuperIgnoreUI", UIParent, "BasicFrameTemplateWithInset")
f:SetSize(300, 180) 
f:SetPoint("CENTER")
f:Hide()
f.title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
f.title:SetPoint("CENTER", f.TitleBg, "CENTER", 0, 0)
f.title:SetText(L.UI_ADD_TITLE)

f.targetNameText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
f.targetNameText:SetPoint("TOP", 0, -35)
f.targetNameText:SetText(L.UI_TARGET_NONE)

f.editBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
f.editBox:SetSize(260, 30)
f.editBox:SetPoint("TOP", 0, -65) 
f.editBox:SetAutoFocus(true)

f.confirm = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
f.confirm:SetSize(80, 25)
f.confirm:SetPoint("BOTTOMLEFT", 40, 20)
f.confirm:SetText(L.UI_BTN_CONFIRM)

f.cancel = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
f.cancel:SetSize(80, 25)
f.cancel:SetPoint("BOTTOMRIGHT", -40, 20)
f.cancel:SetText(L.UI_BTN_CANCEL)
f.cancel:SetScript("OnClick", function() f:Hide() end)

local reasons = {L.BTN_R1, L.BTN_R2, L.BTN_R3, L.BTN_R4}
for i, reason in ipairs(reasons) do
    local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    btn:SetSize(60, 22)
    btn:SetText(reason)
    btn:SetPoint("TOPLEFT", f.editBox, "BOTTOMLEFT", (i-1)*65, -5)
    btn:SetScript("OnClick", function() f.editBox:SetText(reason) end)
end

f.confirm:SetScript("OnClick", function()
    local name = f.playerName
    local reason = f.editBox:GetText()
    if reason == "" then reason = L.REASON_MANUAL end
    
    SuperIgnoreDB = SuperIgnoreDB or {} 
    SuperIgnoreDB[name] = {reason = reason, time = date("%Y-%m-%d %H:%M")}
    
    print(string.format(L.MSG_BLACKLISTED, name, reason))
    f:Hide()
end)

function ShowSuperIgnoreUI(name)
    if not name or name == "" then return end

    if not string.find(name, "-") then
        print(L.MSG_ERR_NO_REALM)
        return
    end

    f.playerName = name
    f.targetNameText:SetText(L.UI_TARGET_PREFIX .. name .. "|r") 
    f.editBox:SetText("")
    f:Show()
end

-- 5. 菜单注入逻辑
local function InjectSuperIgnore(ownerRegion, rootDescription, contextData)
    if not contextData then return end
    
    local finalName = nil
    local myRealm = GetNormalizedRealmName() or ""
    
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
    
    if not finalName and contextData.name then
        finalName = contextData.name
        if not string.find(finalName, "-") and contextData.server and contextData.server ~= "" then
            finalName = finalName .. "-" .. contextData.server
        end
    end
    
    if not finalName and contextData.link then
        local linkName = string.match(contextData.link, "player:([^:]+)")
        if linkName then finalName = linkName end
    end
    
    if finalName and finalName ~= "" then
        finalName = string.gsub(finalName, "%s+", "")
        
        if not string.find(finalName, "-") and myRealm ~= "" then
            finalName = finalName .. "-" .. myRealm
        end
        
        local myName = UnitName("player")
        if finalName == (myName .. "-" .. myRealm) then return end
        
        rootDescription:CreateDivider()
        rootDescription:CreateButton(L.MENU_ADD, function()
            ShowSuperIgnoreUI(finalName)
        end)
    end
end

if Menu and Menu.ModifyMenu then
    local menuList = {"MENU_UNIT_PLAYER", "MENU_UNIT_TARGET", "MENU_UNIT_PARTY", "MENU_UNIT_RAID_PLAYER", "MENU_CHAT_PLAYER", "MENU_CHAT_LINK", "MENU_CHAT_ROSTER", "MENU_UNIT_FRIEND"}
    for _, menuID in ipairs(menuList) do
        Menu.ModifyMenu(menuID, InjectSuperIgnore)
    end
end

-- 6. 斜杠命令
SLASH_SUPERIGNORE1 = "/si"
SlashCmdList["SUPERIGNORE"] = function()
    if InCombatLockdown() then
        print(L.MSG_ERR_COMBAT)
        return
    end

    if SuperIgnoreCategory then
        Settings.OpenToCategory(SuperIgnoreCategory:GetID())
    else
        print(L.MSG_ERR_NO_PANEL)
    end
end

-- 7. 插件管理面板
local panel = CreateFrame("Frame", "SuperIgnoreOptionsPanel")
local addonVersion = C_AddOns.GetAddOnMetadata("SuperIgnore", "Version")

panel.name = "SuperIgnore" 

local panelTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
panelTitle:SetPoint("TOPLEFT", 16, -16)
panelTitle:SetText("SuperIgnore v" .. (addonVersion or L.UNKNOWN_VERSION))

local panelDesc1 = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
panelDesc1:SetPoint("TOPLEFT", panelTitle, "BOTTOMLEFT", 0, -10)
panelDesc1:SetText(L.PANEL_DESC1)

local panelDesc2 = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
panelDesc2:SetPoint("TOPLEFT", panelDesc1, "BOTTOMLEFT", 0, -6)
panelDesc2:SetText(L.PANEL_DESC2)

local currentMode = "PLAYER" 

local btnPlayers = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnPlayers:SetSize(100, 25)
btnPlayers:SetPoint("TOPLEFT", 16, -95)
btnPlayers:SetText(L.TAB_PLAYER)

local btnKeywords = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnKeywords:SetSize(100, 25)
btnKeywords:SetPoint("LEFT", btnPlayers, "RIGHT", 10, 0)
btnKeywords:SetText(L.TAB_KEYWORD)

local btnData = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnData:SetSize(100, 25)
btnData:SetPoint("LEFT", btnKeywords, "RIGHT", 10, 0)
btnData:SetText(L.TAB_DATA)

local btnAbout = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAbout:SetSize(80, 25)
btnAbout:SetPoint("LEFT", btnData, "RIGHT", 10, 0)
btnAbout:SetText(L.TAB_ABOUT)

local addPlayerNameBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addPlayerNameBox:SetSize(130, 30)
addPlayerNameBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 5, -35)
addPlayerNameBox:SetAutoFocus(false)
addPlayerNameBox.title = addPlayerNameBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addPlayerNameBox.title:SetPoint("BOTTOMLEFT", addPlayerNameBox, "TOPLEFT", 0, 5)
addPlayerNameBox.title:SetText(L.UI_PLAYER_INPUT)

local addPlayerReasonBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addPlayerReasonBox:SetSize(100, 30)
addPlayerReasonBox:SetPoint("LEFT", addPlayerNameBox, "RIGHT", 15, 0)
addPlayerReasonBox:SetAutoFocus(false)
addPlayerReasonBox.title = addPlayerReasonBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addPlayerReasonBox.title:SetPoint("BOTTOMLEFT", addPlayerReasonBox, "TOPLEFT", 0, 5)
addPlayerReasonBox.title:SetText(L.UI_REASON_INPUT)

local quickBtns = {}
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
btnAddPlayer:SetText(L.UI_BTN_ADD)

local addWordBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addWordBox:SetSize(180, 30)
addWordBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 5, -35)
addWordBox:SetAutoFocus(false)
addWordBox.title = addWordBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addWordBox.title:SetPoint("BOTTOMLEFT", addWordBox, "TOPLEFT", 0, 5)
addWordBox.title:SetText(L.UI_KEYWORD_INPUT)

local btnAddWord = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAddWord:SetSize(60, 25)
btnAddWord:SetPoint("LEFT", addWordBox, "RIGHT", 10, 0)
btnAddWord:SetText(L.UI_BTN_ADD)

local searchBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
searchBox:SetSize(200, 30)
searchBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 45, -90)
searchBox:SetAutoFocus(false)
searchBox.title = searchBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
searchBox.title:SetPoint("RIGHT", searchBox, "LEFT", -5, 0)
searchBox.title:SetText(L.UI_SEARCH)

local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -5, -10)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 20)


scrollFrame:EnableMouseWheel(true)
scrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local currentScroll = self:GetVerticalScroll()
    local maxScroll = self:GetVerticalScrollRange()
    local step = 30 
    
    local newScroll = currentScroll - (delta * step)
    if newScroll < 0 then newScroll = 0 end
    if newScroll > maxScroll then newScroll = maxScroll end
    
    self:SetVerticalScroll(newScroll)
end)

local scrollChild = CreateFrame("Frame", nil, scrollFrame)
scrollChild:SetSize(550, 1) 
scrollFrame:SetScrollChild(scrollChild)


local rows = {}

local dataFrame = CreateFrame("Frame", nil, panel)
dataFrame:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 0, -20)
dataFrame:SetPoint("BOTTOMRIGHT", -30, 20)
dataFrame:Hide()

local btnGenerate = CreateFrame("Button", nil, dataFrame, "UIPanelButtonTemplate")
btnGenerate:SetSize(120, 25)
btnGenerate:SetPoint("TOPLEFT", 5, 0)
btnGenerate:SetText(L.UI_BTN_EXPORT)

local btnImportData = CreateFrame("Button", nil, dataFrame, "UIPanelButtonTemplate")
btnImportData:SetSize(130, 25)
btnImportData:SetPoint("LEFT", btnGenerate, "RIGHT", 20, 0)
btnImportData:SetText(L.UI_BTN_IMPORT)

local btnSyncMS = CreateFrame("Button", nil, dataFrame, "UIPanelButtonTemplate")
btnSyncMS:SetSize(160, 25)
btnSyncMS:SetPoint("LEFT", btnImportData, "RIGHT", 20, 0) 
btnSyncMS:SetText(L.UI_BTN_SYNC)

local chkAutoSync = CreateFrame("CheckButton", nil, dataFrame, "InterfaceOptionsCheckButtonTemplate")
chkAutoSync:SetPoint("LEFT", btnSyncMS, "RIGHT", 15, 0)
chkAutoSync.Text:SetText(L.UI_CHK_AUTOSYNC)
chkAutoSync.Text:SetFontObject("GameFontHighlightSmall")
chkAutoSync:SetScript("OnClick", function(self)
    SuperIgnoreDB = SuperIgnoreDB or {}
    SuperIgnoreDB["__CONFIG_AUTOSYNC__"] = self:GetChecked()
end)

local dataStatsText = dataFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
dataStatsText:SetPoint("TOPLEFT", btnGenerate, "BOTTOMLEFT", 5, -8)

local dataScroll = CreateFrame("ScrollFrame", nil, dataFrame, "UIPanelScrollFrameTemplate")
dataScroll:SetPoint("TOPLEFT", btnGenerate, "BOTTOMLEFT", 0, -25)
dataScroll:SetPoint("BOTTOMRIGHT", 0, 0)


dataScroll:EnableMouseWheel(true)
dataScroll:SetScript("OnMouseWheel", function(self, delta)
    local currentScroll = self:GetVerticalScroll()
    local maxScroll = self:GetVerticalScrollRange()
    local step = 50 
    
    local newScroll = currentScroll - (delta * step)
    if newScroll < 0 then newScroll = 0 end
    if newScroll > maxScroll then newScroll = maxScroll end
    
    self:SetVerticalScroll(newScroll)
end)

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

local aboutFrame = CreateFrame("Frame", nil, panel)
aboutFrame:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 0, -20)
aboutFrame:SetPoint("BOTTOMRIGHT", -30, 20)
aboutFrame:Hide()

local aboutTitle = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
aboutTitle:SetPoint("TOPLEFT", 10, -10)
aboutTitle:SetText(L.ABOUT_TITLE)

local aboutAuthor = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
aboutAuthor:SetPoint("TOPLEFT", aboutTitle, "BOTTOMLEFT", 0, -15)
aboutAuthor:SetText(L.ABOUT_TEXT)
aboutAuthor:SetJustifyH("LEFT") 

local ngaTitle = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
ngaTitle:SetPoint("TOPLEFT", aboutAuthor, "BOTTOMLEFT", 0, -20)
ngaTitle:SetText(L.ABOUT_NGA)

local ngaBox = CreateFrame("EditBox", nil, aboutFrame, "InputBoxTemplate")
ngaBox:SetSize(420, 30)
ngaBox:SetPoint("TOPLEFT", ngaTitle, "BOTTOMLEFT", 5, -5)
ngaBox:SetAutoFocus(false)
ngaBox:SetText("https://bbs.nga.cn/read.php?tid=47106371")
ngaBox:SetCursorPosition(0)
ngaBox:SetScript("OnTextChanged", function(self)
    if self:GetText() ~= "https://bbs.nga.cn/read.php?tid=47106371" then
        self:SetText("https://bbs.nga.cn/read.php?tid=47106371")
    end
end)

local urlTitle = aboutFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
urlTitle:SetPoint("TOPLEFT", ngaBox, "BOTTOMLEFT", -5, -15)
urlTitle:SetText(L.ABOUT_CF)

local urlBox = CreateFrame("EditBox", nil, aboutFrame, "InputBoxTemplate")
urlBox:SetSize(420, 30)
urlBox:SetPoint("TOPLEFT", urlTitle, "BOTTOMLEFT", 5, -5)
urlBox:SetAutoFocus(false)
urlBox:SetText("https://www.curseforge.com/wow/addons/superignore")
urlBox:SetCursorPosition(0)
urlBox:SetScript("OnTextChanged", function(self)
    if self:GetText() ~= "https://www.curseforge.com/wow/addons/superignore" then
        self:SetText("https://www.curseforge.com/wow/addons/superignore")
    end
end)

local function RefreshList()
    addPlayerNameBox:Hide(); addPlayerReasonBox:Hide(); btnAddPlayer:Hide()
    for _, b in ipairs(quickBtns) do b:Hide() end
    addWordBox:Hide(); btnAddWord:Hide()
    dataFrame:Hide()
    aboutFrame:Hide()
    
    btnPlayers:UnlockHighlight()
    btnKeywords:UnlockHighlight()
    btnData:UnlockHighlight()
    btnAbout:UnlockHighlight()

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
        
        if SuperIgnoreDB and SuperIgnoreDB["__CONFIG_AUTOSYNC__"] == false then
            chkAutoSync:SetChecked(false)
        else
            chkAutoSync:SetChecked(true)
        end
        
        local pCount, kCount = 0, 0
        for k, _ in pairs(SuperIgnoreDB or {}) do 
            if k ~= "__CONFIG_AUTOSYNC__" then pCount = pCount + 1 end 
        end
        for _ in pairs(SuperIgnoreKeywordsDB or {}) do kCount = kCount + 1 end
        
        if dataStatsText then
            dataStatsText:SetText(string.format(L.STATS_TEXT, pCount, kCount))
        end
        
        searchBox:Hide(); scrollFrame:Hide()
        return 
        
    elseif currentMode == "ABOUT" then
        btnAbout:LockHighlight()
        aboutFrame:Show()
        
        searchBox:Hide(); scrollFrame:Hide()
        return
    end
    
    if currentMode ~= "DATA" and currentMode ~= "ABOUT" then
        searchBox:Show(); scrollFrame:Show()
    end

    local filter = searchBox:GetText():lower()
    for _, row in ipairs(rows) do row:Hide() end
    
    local yOffset = 0
    local rowIndex = 1
    local targetDB = (currentMode == "PLAYER") and SuperIgnoreDB or SuperIgnoreKeywordsDB
    local myRealm = GetNormalizedRealmName()

    -- 【修改1】：将无序的哈希表转为数组，以便进行时间排序
    local sortedItems = {}
    if targetDB then
        for key, data in pairs(targetDB) do
            if key ~= "__CONFIG_AUTOSYNC__" then
                table.insert(sortedItems, {key = key, data = data})
            end
        end
        
        -- 【修改2】：按照时间进行降序排序（最新的在前面）
        table.sort(sortedItems, function(a, b)
            local timeA = (currentMode == "PLAYER") and (type(a.data) == "table" and a.data.time or "") or tostring(a.data)
            local timeB = (currentMode == "PLAYER") and (type(b.data) == "table" and b.data.time or "") or tostring(b.data)
            return timeA > timeB 
        end)
    end

    -- 【修改3】：改用 ipairs 遍历排好序的数组
    for _, item in ipairs(sortedItems) do
        local key = item.key
        local data = item.data
        local displayKey = key
        local subText = ""

        if currentMode == "PLAYER" then
            local reason = data.reason or L.LIST_REASON_NONE
            local timeStr = data.time or ""
            -- 【修改4】：将格式重组为 “时间    备注” 
            subText = timeStr .. "    " .. reason
            if not displayKey:find("-") then displayKey = displayKey .. "-" .. myRealm end
        else
            subText = L.LIST_ADD_TIME .. tostring(data)
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
                row.removeBtn:SetText(L.LIST_BTN_REMOVE)
                
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
    
    scrollChild:SetHeight(math.max(yOffset + 10, 1))
end

btnPlayers:SetScript("OnClick", function() currentMode = "PLAYER"; RefreshList() end)
btnKeywords:SetScript("OnClick", function() currentMode = "KEYWORD"; RefreshList() end)
btnData:SetScript("OnClick", function() currentMode = "DATA"; RefreshList() end)
btnAbout:SetScript("OnClick", function() currentMode = "ABOUT"; RefreshList() end) 

btnAddPlayer:SetScript("OnClick", function()
    local name = addPlayerNameBox:GetText()
    if not name or name == "" then return end
    
    name = string.match(name, "^%s*(.-)%s*$")
    
    if not string.find(name, "-") then
        local myRealm = GetNormalizedRealmName() or ""
        if myRealm ~= "" then
            name = name .. "-" .. myRealm
        end
    end
    
    if not string.find(name, "-") then
        print(L.MSG_ERR_FORMAT)
        return
    end
    
    local reason = addPlayerReasonBox:GetText()
    if reason == "" then reason = L.REASON_MANUAL end
    
    SuperIgnoreDB[name] = {reason = reason, time = date("%Y-%m-%d %H:%M")}
    
    addPlayerNameBox:SetText("")
    addPlayerReasonBox:SetText("")
    RefreshList()
    print(string.format(L.MSG_BLACKLISTED, name, reason))
end)

btnAddWord:SetScript("OnClick", function()
    local word = addWordBox:GetText()
    if word and word ~= "" then
        SuperIgnoreKeywordsDB[word] = date("%Y-%m-%d %H:%M")
        
        addWordBox:SetText("")
        RefreshList()
        print(string.format(L.MSG_ADDED_KEYWORD, word))
    end
end)

btnGenerate:SetScript("OnClick", function()
    local lines = {"--SuperIgnoreDataV1"}
    
    for k, v in pairs(SuperIgnoreDB or {}) do
        table.insert(lines, "P^" .. k .. "^" .. (v.reason or "") .. "^" .. (v.time or ""))
    end
    
    for k, v in pairs(SuperIgnoreKeywordsDB or {}) do
        table.insert(lines, "K^" .. k .. "^" .. tostring(v))
    end
    
    dataEditBox:SetText(table.concat(lines, "\n"))
    dataEditBox:HighlightText()
    print(L.MSG_EXPORTED)
end)

btnImportData:SetScript("OnClick", function()
    local str = dataEditBox:GetText()
    
    if not str or str == "" then return end
    if not string.find(str, "--SuperIgnoreDataV1", 1, true) then
        print(L.MSG_ERR_IMPORT)
        return
    end
    
    local pCount, kCount = 0, 0
    local skipCount = 0
    
    for line in str:gmatch("[^\r\n]+") do
        line = string.match(line, "^%s*(.-)%s*$")
        if line and line ~= "" and string.sub(line, 1, 2) ~= "--" then
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
            
            if typeTag == "P" and nameOrWord ~= "" then
                if string.find(nameOrWord, "-") then
                    SuperIgnoreDB = SuperIgnoreDB or {}
                    SuperIgnoreDB[nameOrWord] = { reason = reason ~= "" and reason or L.REASON_IMPORT, time = time ~= "" and time or date("%Y-%m-%d %H:%M") }
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

    local msg = string.format(L.MSG_IMPORT_SUCCESS, pCount, kCount)
    if skipCount > 0 then
        msg = msg .. string.format(L.MSG_IMPORT_FILTERED, skipCount)
    end
    print(msg)
    
    dataEditBox:SetText("")
    pcall(RefreshList)
end) 

local function DoSyncMeetingStone(isAuto)
    if not MEETINGSTONE_UI_DB or not MEETINGSTONE_UI_DB.global or not MEETINGSTONE_UI_DB.global.UIMemory or not MEETINGSTONE_UI_DB.global.UIMemory.IGNORE_LIST then
        if not isAuto then
            print(L.MSG_ERR_NO_MS)
        end
        return
    end

    local msList = MEETINGSTONE_UI_DB.global.UIMemory.IGNORE_LIST
    local count = 0
    SuperIgnoreDB = SuperIgnoreDB or {}

    for _, data in ipairs(msList) do
        local name = data.leader
        local reason = data.dep or L.REASON_MS
        local timeStr = data.time or date("%Y-%m-%d %H:%M")

        if name and name ~= "" and string.find(name, "-") and not SuperIgnoreDB[name] then
            SuperIgnoreDB[name] = { reason = reason, time = timeStr }
            count = count + 1
        end
    end

    if count > 0 then
        print(string.format(L.MSG_MS_SUCCESS, count))
        if RefreshList then RefreshList() end
    else
        if not isAuto then
            print(L.MSG_MS_EMPTY)
        end
    end
end

btnSyncMS:SetScript("OnClick", function() 
    DoSyncMeetingStone(false)
end)

searchBox:SetScript("OnTextChanged", RefreshList)

panel:SetScript("OnShow", function()
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
