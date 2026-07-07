-- SuperIgnore v1.4.0
-- A lightweight, account-wide ignore list management & chat filter tool.
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
	MENU_WHITELIST = "Add to Whitelist",  
    REASON_MANUAL = "Manual Add",
    REASON_IMPORT = "Imported",
    REASON_MS = "MeetingStone Sync",
    UNKNOWN_VERSION = "Unknown Version",
    
		
    PANEL_DESC1 = "SuperIgnore is a lightweight, high-performance chat filtering & ignore list addon.",
    PANEL_DESC2 = "Account-wide ignore. Block once, clean chat on all characters!",
    
    TAB_PLAYER = "Block Player",
    TAB_KEYWORD = "Block Keyword",
    TAB_FILTERS = "Filters",
    TAB_DATA = "Data/Sync",
    TAB_ABOUT = "About",
    
	TAB_WHITELIST = "Whitelist",
    UI_WHITELIST_INPUT = "Whitelist Player-Realm:",
    MSG_WHITELISTED = "|cff00ff00[SuperIgnore]|r Whitelisted: %s",
	
    UI_PLAYER_INPUT = "Player-Realm:",
    UI_REASON_INPUT = "Note:",
    UI_BTN_ADD = "Add",
    UI_KEYWORD_INPUT = "New Keyword (Regex):",
    
    UI_SEARCH = "Search:",
    UI_BTN_EXPORT = "Export Data",
    UI_BTN_IMPORT = "Import & Merge",
    UI_BTN_SYNC = "Sync MeetingStone",
    
    UI_CHK_AUTOSYNC = "Auto-sync panel open",
    UI_CHK_DND = "Block AFK/DND player messages",
    UI_CHK_REPEAT = "Block repeated messages (Anti-spam)",
    UI_CHK_ACHV = "Merge duplicate achievements",
    UI_CHK_NPC = "Block repetitive NPC dialogues",
    UI_CHK_QUEST = "Block quest/instance progress spam",
    
    STATS_TEXT = "Stats: %d Players blocked, %d Keywords blocked",
    ABOUT_TITLE = "SuperIgnore",
	ABOUT_TEXT = "Author: okqiyi \nVersion: v1.4.0\n\n【v1.4.0 Updates】\n- New: Silently decline guild invites and duels from blocked players.\n- Optimized UI layout and zero-bloat performance.\n\nFeedback and bug reports are always welcome on CurseForge!",
    ABOUT_NGA = "NGA (Ctrl+C to copy):",
    ABOUT_CF = "CurseForge (Ctrl+C to copy):",
    
    LIST_REASON_NONE = "None",
    LIST_ADD_TIME = "Added: ",
    LIST_BTN_REMOVE = "Remove",
    
    MSG_GROUP_DECLINED = "|cffff0000[SuperIgnore]|r Auto-declined group invite from blocked player %s.",
    MSG_TRADE_DECLINED = "|cffff0000[SuperIgnore]|r Auto-declined trade request from blocked player %s.",
    MSG_BLACKLISTED = "|cffff0000[SuperIgnore]|r Blocked %s. Reason: %s",
    MSG_ADDED_KEYWORD = "|cffff0000[SuperIgnore]|r Added keyword: %s",
    MSG_EXPORTED = "|cffff0000[SuperIgnore]|r Code generated. Press Ctrl+C to copy.",
    MSG_IMPORT_SUCCESS = "|cff00ff00[SuperIgnore]|r Import complete. Added: %d Players, %d Keywords.",
    MSG_IMPORT_FILTERED = " |cffffff00Auto-filtered %d invalid entries without realm.|r",
    MSG_MS_SUCCESS = "|cff00ff00[SuperIgnore]|r Auto-sync triggered! Silently added %d new players to global list.",
    
    MSG_ERR_NO_REALM = "|cffff0000[SuperIgnore]|r Failed to get realm info, block failed!",
    MSG_ERR_COMBAT = "|cffff0000[SuperIgnore]|r Cannot open settings in combat.",
    MSG_ERR_NO_PANEL = "|cffff0000[SuperIgnore]|r Error: Settings panel not initialized.",
    MSG_ERR_FORMAT = "|cffff0000[SuperIgnore]|r Error: Must include realm name (e.g., Player-Realm)!",
    MSG_ERR_IMPORT = "|cffff0000[SuperIgnore]|r Invalid format! Must include --SuperIgnoreDataV1",
    MSG_ERR_NO_MS = "|cffff0000[SuperIgnore]|r MeetingStone addon not found or list empty.",
    MSG_MS_EMPTY = "|cffffff00[SuperIgnore]|r MeetingStone list already synced. No new players found."
}

local locale = GetLocale()
-- local locale = "enUS"


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
	L.MENU_WHITELIST = "加入超级白名单"  
    L.REASON_MANUAL = "手动添加"
    L.REASON_IMPORT = "导入"
    L.REASON_MS = "集合石同步"
    L.UNKNOWN_VERSION = "未知版本"
    L.PANEL_DESC1 = "SuperIgnore (超级黑名单) 是一款极简、轻量、高性能的聊天过滤与黑名单管理插件。"
    L.PANEL_DESC2 = "一次拉黑，全战网所有角色共同生效，还你清净的艾泽拉斯！"
	
	L.TAB_WHITELIST = "白名单"
    L.UI_WHITELIST_INPUT = "白名单玩家-服务器:"
    L.MSG_WHITELISTED = "|cff00ff00[SuperIgnore]|r 已将 %s 加入超级白名单。"
    
    L.TAB_PLAYER = "屏蔽玩家"
    L.TAB_KEYWORD = "屏蔽关键词"
    L.TAB_FILTERS = "扩展过滤"
    L.TAB_DATA = "数据/同步"
    L.TAB_ABOUT = "关于"
    
    L.UI_PLAYER_INPUT = "玩家-服务器:"
    L.UI_REASON_INPUT = "备注:"
    L.UI_BTN_ADD = "添加"
    L.UI_KEYWORD_INPUT = "新增屏蔽词 (支持正则):"
    L.UI_SEARCH = "搜索:"
    L.UI_BTN_EXPORT = "生成导出代码"
    L.UI_BTN_IMPORT = "导入覆盖合并"
    L.UI_BTN_SYNC = "同步集合石屏蔽列表"
    
    L.UI_CHK_AUTOSYNC = "打开面板自动同步"
    L.UI_CHK_DND = "拦截 暂离/忙碌 玩家发言"
    L.UI_CHK_REPEAT = "拦截玩家连续重复发言 (防刷屏)"
    L.UI_CHK_ACHV = "合并公会/队伍同款成就 (防霸屏)"
    L.UI_CHK_NPC = "拦截 NPC 高频重复台词"
    L.UI_CHK_QUEST = "拦截队伍/副本任务进度通告"
    
    L.STATS_TEXT = "当前统计：已拦截玩家 %d 名，屏蔽关键词 %d 个"
    L.ABOUT_TITLE = "SuperIgnore (超级黑名单)"
	L.ABOUT_TEXT = "作者: okqiyi \n版本: v1.4.0\n\n【v1.4.0 核心更新】\n- 新增：全面静默拦截黑名单玩家的公会邀请与决斗请求。\n- 优化：中英双语排版适配，持续保持极简零污染架构。\n\n如果遇到 Bug 或有功能建议，欢迎前往 NGA 原创插件区反馈！"
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
	L.MENU_WHITELIST = "加入超級白名單"  
    L.REASON_MANUAL = "手動加入"
    L.REASON_IMPORT = "匯入"
    L.REASON_MS = "集合石同步"
    L.UNKNOWN_VERSION = "未知版本"
    L.PANEL_DESC1 = "SuperIgnore (超級黑名單) 是一款極簡、輕量、高效能的聊天過濾與黑名單管理插件。"
    L.PANEL_DESC2 = "一次黑單，全戰網所有角色共同生效，還你清淨的艾澤拉斯！"
	
	L.TAB_WHITELIST = "白名單"
    L.UI_WHITELIST_INPUT = "白名單玩家-伺服器:"
    L.MSG_WHITELISTED = "|cff00ff00[SuperIgnore]|r 已將 %s 加入超級白名單。"
    
    L.TAB_PLAYER = "封鎖玩家"
    L.TAB_KEYWORD = "封鎖關鍵字"
    L.TAB_FILTERS = "擴展過濾"
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
    L.UI_CHK_DND = "攔截 暫離/忙碌 玩家發言"
    L.UI_CHK_REPEAT = "攔截玩家連續重複發言 (防洗頻)"
    L.UI_CHK_ACHV = "合併公會/隊伍同款成就 (防霸屏)"
    L.UI_CHK_NPC = "攔截 NPC 高頻重複台詞"
    L.UI_CHK_QUEST = "攔截隊伍/副本任務進度通告"
    
    L.STATS_TEXT = "當前統計：已攔截玩家 %d 名，封鎖關鍵字 %d 個"
    L.ABOUT_TITLE = "SuperIgnore (超級黑名單)"
	L.ABOUT_TEXT = "作者: okqiyi \n版本: v1.4.0\n\n【v1.4.0 核心更新】\n- 新增：全面靜默攔截黑名單玩家的公會邀請與決鬥請求。\n- 優化：中英雙語排版適配，持續保持極簡零污染架構。\n\n如果遇到 Bug 或有功能建議，歡迎前往 CurseForge 反饋！"
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
SuperIgnoreWhiteListDB = SuperIgnoreWhiteListDB or {} -- 【新增】：独立的白名单库

-- 【新增】内存级防抖缓存表 (重启游戏即清空，零负担)
local repeatCache = {}
local achvCache = {}
local npcCache = {}




-- 2. 聊天过滤模块与智能拦截模块
local function ChatFilter(self, event, msg, author, ...)
    local name = Ambiguate(author, "none")
    
    -- 【新增】：最高优先级 -> 白名单检测
    if SuperIgnoreWhiteListDB and SuperIgnoreWhiteListDB[name] then
        return false -- 白名单玩家，直接无条件放行
    end

    -- 【修复后的强硬过滤逻辑】：不再直接调用 UnitAFK(author)
    if SuperIgnoreDB["__CONFIG_FILTER_DND_PLAYER__"] ~= false then
        if name ~= UnitName("player") then
            -- 排除公共大频道（CHAT_MSG_CHANNEL），其他频道（私聊/说/大喊/小队/团队）全部生效
            if event ~= "CHAT_MSG_CHANNEL" then
                if UnitIsAFK(author) or UnitIsDND(author) then
                    return true
                end
            end
        end
    end
    
    -- A. 关键词/正则匹配拦截
    if SuperIgnoreKeywordsDB then
        for keyword, _ in pairs(SuperIgnoreKeywordsDB) do
            if msg:find(keyword) then
                return true
            end
        end
    end
    
    -- B. 超级黑名单拦截
    local name, realm = strsplit("-", author)
    if not realm or realm == "" then
        realm = GetNormalizedRealmName()
    end
    local fullName = name .. "-" .. realm
    if SuperIgnoreDB[fullName] or SuperIgnoreDB[author] then
        return true 
    end
    
    -- C. 【新增】智能过滤器：重复信息防刷屏 (15秒内同一个人发一模一样的话)
    if SuperIgnoreDB["__CONFIG_FILTER_REPEAT__"] ~= false then
        local now = GetTime()
        if repeatCache[author] and repeatCache[author].msg == msg and (now - repeatCache[author].time < 15) then
            return true -- 拦截重复刷屏
        end
        repeatCache[author] = {msg = msg, time = now}
    end
    
    -- D. 【新增】智能过滤器：任务组队通告过滤 (匹配典型的任务进度播报)
    if SuperIgnoreDB["__CONFIG_FILTER_QUEST__"] ~= false then
        if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_INSTANCE_CHAT" then
            -- 匹配 "1/10" 或者包含 "任务进度" 等常见通告特征
            if string.find(msg, "%d+/%d+") or string.find(msg, "任务") or string.find(msg, "进度") or string.find(msg, "Quest") then
                return true
            end
        end
    end
    
    return false
end

-- 注册常规聊天频道
local chatEvents = {
    "CHAT_MSG_CHANNEL", "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER",
    "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER"
}
for _, ev in ipairs(chatEvents) do
    ChatFrame_AddMessageEventFilter(ev, ChatFilter)
end

-- 【新增】智能过滤器：DND/AFK 自动回复拦截
local function FilterDND(self, event, msg, ...)
    if SuperIgnoreDB["__CONFIG_FILTER_DND__"] ~= false then
        return true
    end
    return false
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", FilterDND)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", FilterDND)

-- 【新增】智能过滤器：成就防霸屏 (10秒内同一个成就只显示一次)
local function FilterAchv(self, event, msg, ...)
    if SuperIgnoreDB["__CONFIG_FILTER_ACHV__"] ~= false then
        local achvLink = string.match(msg, "(|Hachievement.-|h)")
        if achvLink then
            local now = GetTime()
            if achvCache[achvLink] and (now - achvCache[achvLink] < 10) then
                return true 
            end
            achvCache[achvLink] = now
        end
    end
    return false
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", FilterAchv)
ChatFrame_AddMessageEventFilter("CHAT_MSG_ACHIEVEMENT", FilterAchv)

-- 【新增】智能过滤器：NPC 重复说话过滤 (60秒内同一台词只显示一次)
local function FilterNPC(self, event, msg, author, ...)
    if SuperIgnoreDB["__CONFIG_FILTER_NPC__"] ~= false then
        local now = GetTime()
        local key = (author or "NPC") .. msg
        if npcCache[key] and (now - npcCache[key] < 60) then
            return true
        end
        npcCache[key] = now
    end
    return false
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", FilterNPC)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", FilterNPC)


-- ==========================================
-- 3. 组队、交易、公会邀请与决斗拦截模块（全面封杀黑名单用户）
-- ==========================================
local frame = CreateFrame("Frame")
frame:RegisterEvent("PARTY_INVITE_REQUEST")
frame:RegisterEvent("TRADE_REQUEST")
frame:RegisterEvent("GUILD_INVITE_REQUEST") -- 【新增】注册公会邀请事件
frame:RegisterEvent("DUEL_REQUESTED")        -- 【新增】注册决斗请求事件

frame:SetScript("OnEvent", function(self, event, sender, ...)
    local cleanSender = Ambiguate(sender, "none")
    
    -- 只要对方在你的通用黑名单里，直接执行全方位全自动拦截
    if SuperIgnoreDB[sender] or SuperIgnoreDB[cleanSender] then
        if event == "PARTY_INVITE_REQUEST" then
            DeclineGroup()
            StaticPopup_Hide("PARTY_INVITE")
            print(string.format(L.MSG_GROUP_DECLINED, sender))
            
        elseif event == "TRADE_REQUEST" then
            CancelTrade()
            print(string.format(L.MSG_TRADE_DECLINED, sender))
            
        elseif event == "GUILD_INVITE_REQUEST" then
            DeclineGuild() -- 【新增】静默拒绝公会邀请
            StaticPopup_Hide("GUILD_INVITE") -- 隐藏系统的弹窗
            
            
        elseif event == "DUEL_REQUESTED" then
            CancelDuel() -- 【新增】静默拒绝决斗请求
            StaticPopup_Hide("DUEL") -- 隐藏系统的弹窗
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
		
		-- 【修改】：加入白名单按钮，调用多语言字典
        rootDescription:CreateButton(L.MENU_WHITELIST, function()
            SuperIgnoreWhiteListDB = SuperIgnoreWhiteListDB or {}
            local cleanName = Ambiguate(finalName, "none")
            
            SuperIgnoreWhiteListDB[cleanName] = date("%Y-%m-%d %H:%M")
            print(string.format(L.MSG_WHITELISTED, cleanName))
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
SLASH_SUPERIGNORE1 = "/si"             -- 保留原有的（抢不抢得到随缘）
SLASH_SUPERIGNORE2 = "/superignore"    -- 新增：绝对不会冲突的全拼
SLASH_SUPERIGNORE3 = "/sig"            -- 新增：备用简写 (Super IGnore)

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


-- ==========================================
-- 调整顶部页签按钮宽度与排版 (新增白名单)
-- ==========================================
local btnPlayers = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnPlayers:SetSize(100, 25) -- 宽度由 75 改为 85
btnPlayers:SetPoint("TOPLEFT", 16, -95)
btnPlayers:SetText(L.TAB_PLAYER)

local btnKeywords = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnKeywords:SetSize(120, 25) -- 宽度由 80 改为 100，给“关键词”留足空间
btnKeywords:SetPoint("LEFT", btnPlayers, "RIGHT", 5, 0)
btnKeywords:SetText(L.TAB_KEYWORD)

local btnWhitelist = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnWhitelist:SetSize(90, 25) -- 宽度由 75 改为 80
btnWhitelist:SetPoint("LEFT", btnKeywords, "RIGHT", 5, 0)
btnWhitelist:SetText(L.TAB_WHITELIST)

local btnFilters = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnFilters:SetSize(85, 25) -- 宽度由 75 改为 85
btnFilters:SetPoint("LEFT", btnWhitelist, "RIGHT", 5, 0)
btnFilters:SetText(L.TAB_FILTERS)

local btnData = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnData:SetSize(95, 25) -- 宽度由 75 改为 90
btnData:SetPoint("LEFT", btnFilters, "RIGHT", 5, 0)
btnData:SetText(L.TAB_DATA)

local btnAbout = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAbout:SetSize(70, 25) -- 宽度由 65 改为 70
btnAbout:SetPoint("LEFT", btnData, "RIGHT", 5, 0)
btnAbout:SetText(L.TAB_ABOUT)

-- 玩家模块
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
    btn:SetSize(65, 22)
    if i == 1 then
        btn:SetPoint("LEFT", addPlayerReasonBox, "RIGHT", 5, 0)
    else
        btn:SetPoint("LEFT", quickBtns[i-1], "RIGHT", 5, 0)
    end
    btn:SetText(r)
    btn:SetScript("OnClick", function() addPlayerReasonBox:SetText(r) end)
    quickBtns[i] = btn
end

local btnAddPlayer = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAddPlayer:SetSize(60, 25)
btnAddPlayer:SetPoint("LEFT", quickBtns[#quickBtns], "RIGHT", 10, 0)
btnAddPlayer:SetText(L.UI_BTN_ADD)

-- 关键词模块
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

-- 白名单模块
local addWhitelistNameBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
addWhitelistNameBox:SetSize(180, 30)
addWhitelistNameBox:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 5, -35)
addWhitelistNameBox:SetAutoFocus(false)
addWhitelistNameBox.title = addWhitelistNameBox:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
addWhitelistNameBox.title:SetPoint("BOTTOMLEFT", addWhitelistNameBox, "TOPLEFT", 0, 5)
addWhitelistNameBox.title:SetText(L.UI_WHITELIST_INPUT)

local btnAddWhitelist = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
btnAddWhitelist:SetSize(60, 25)
btnAddWhitelist:SetPoint("LEFT", addWhitelistNameBox, "RIGHT", 10, 0)
btnAddWhitelist:SetText(L.UI_BTN_ADD)


-- 搜索与列表
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

-- ==========================================
-- 【新增】扩展过滤页签 (Filters) UI 
-- ==========================================
local filtersFrame = CreateFrame("Frame", nil, panel)
filtersFrame:SetPoint("TOPLEFT", btnPlayers, "BOTTOMLEFT", 0, -20)
filtersFrame:SetPoint("BOTTOMRIGHT", -30, 20)
filtersFrame:Hide()

local function CreateConfigCheck(parent, offsetY, configKey, labelText)
    local chk = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    chk:SetPoint("TOPLEFT", 10, offsetY)
    chk.Text:SetText(labelText)
    chk.Text:SetFontObject("GameFontHighlight")
    chk:SetScript("OnClick", function(self)
        SuperIgnoreDB = SuperIgnoreDB or {}
        SuperIgnoreDB[configKey] = self:GetChecked()
    end)
    return chk
end

local chkDND = CreateConfigCheck(filtersFrame, -10, "__CONFIG_FILTER_DND__", L.UI_CHK_DND)
local chkRepeat = CreateConfigCheck(filtersFrame, -50, "__CONFIG_FILTER_REPEAT__", L.UI_CHK_REPEAT)
local chkAchv = CreateConfigCheck(filtersFrame, -90, "__CONFIG_FILTER_ACHV__", L.UI_CHK_ACHV)
local chkNPC = CreateConfigCheck(filtersFrame, -130, "__CONFIG_FILTER_NPC__", L.UI_CHK_NPC)
local chkQuest = CreateConfigCheck(filtersFrame, -170, "__CONFIG_FILTER_QUEST__", L.UI_CHK_QUEST)

-- 数据与同步模块
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
    addWhitelistNameBox:Hide(); btnAddWhitelist:Hide() -- 【新增这句】
    dataFrame:Hide()
    aboutFrame:Hide()
    filtersFrame:Hide()
    
    btnPlayers:UnlockHighlight()
    btnKeywords:UnlockHighlight()
    btnWhitelist:UnlockHighlight() 
    btnFilters:UnlockHighlight()
    btnData:UnlockHighlight()
    btnAbout:UnlockHighlight()

    if currentMode == "PLAYER" then
        btnPlayers:LockHighlight()
        addPlayerNameBox:Show(); addPlayerReasonBox:Show(); btnAddPlayer:Show()
        for _, b in ipairs(quickBtns) do b:Show() end
        
    elseif currentMode == "KEYWORD" then
		btnKeywords:LockHighlight()
        addWordBox:Show(); btnAddWord:Show()
		
	elseif currentMode == "WHITELIST" then
        btnWhitelist:LockHighlight()
        addWhitelistNameBox:Show(); btnAddWhitelist:Show()
		
       
        
    elseif currentMode == "FILTERS" then
        btnFilters:LockHighlight()
        filtersFrame:Show()
        
        -- 读取数据库状态刷新UI，如果是 nil 则默认为 true (打勾)
        SuperIgnoreDB = SuperIgnoreDB or {}
        chkDND:SetChecked(SuperIgnoreDB["__CONFIG_FILTER_DND__"] ~= false)
        chkRepeat:SetChecked(SuperIgnoreDB["__CONFIG_FILTER_REPEAT__"] ~= false)
        chkAchv:SetChecked(SuperIgnoreDB["__CONFIG_FILTER_ACHV__"] ~= false)
        chkNPC:SetChecked(SuperIgnoreDB["__CONFIG_FILTER_NPC__"] ~= false)
        chkQuest:SetChecked(SuperIgnoreDB["__CONFIG_FILTER_QUEST__"] ~= false)
        
        searchBox:Hide(); scrollFrame:Hide()
        return
        
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
            -- 【极简优化】：不再一个个枚举，直接拦截所有 __CONFIG_ 前缀
            if string.sub(k, 1, 9) ~= "__CONFIG_" then pCount = pCount + 1 end 
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
    
    if currentMode ~= "DATA" and currentMode ~= "ABOUT" and currentMode ~= "FILTERS" then
        searchBox:Show(); scrollFrame:Show()
    end

    local filter = searchBox:GetText():lower()
    for _, row in ipairs(rows) do row:Hide() end
    
    local yOffset = 0
    local rowIndex = 1
    local targetDB = nil
    if currentMode == "PLAYER" then targetDB = SuperIgnoreDB
    elseif currentMode == "KEYWORD" then targetDB = SuperIgnoreKeywordsDB
    elseif currentMode == "WHITELIST" then targetDB = SuperIgnoreWhiteListDB
    end
    local myRealm = GetNormalizedRealmName()

    local sortedItems = {}
    if targetDB then
        for key, data in pairs(targetDB) do
            -- 拦截前缀
            if string.sub(key, 1, 9) ~= "__CONFIG_" then
                table.insert(sortedItems, {key = key, data = data})
            end
        end
        
        table.sort(sortedItems, function(a, b)
            local timeA = (currentMode == "PLAYER") and (type(a.data) == "table" and a.data.time or "") or tostring(a.data)
            local timeB = (currentMode == "PLAYER") and (type(b.data) == "table" and b.data.time or "") or tostring(b.data)
            return timeA > timeB 
        end)
    end

    for _, item in ipairs(sortedItems) do
        local key = item.key
        local data = item.data
        local displayKey = key
        local subText = ""

        if currentMode == "PLAYER" then
            local reason = data.reason or L.LIST_REASON_NONE
            local timeStr = data.time or ""
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
                row.removeBtn:SetSize(75, 22)
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
btnFilters:SetScript("OnClick", function() currentMode = "FILTERS"; RefreshList() end)
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

btnWhitelist:SetScript("OnClick", function() currentMode = "WHITELIST"; RefreshList() end)

btnAddWhitelist:SetScript("OnClick", function()
    local name = addWhitelistNameBox:GetText()
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
    
    SuperIgnoreWhiteListDB = SuperIgnoreWhiteListDB or {}
    SuperIgnoreWhiteListDB[name] = date("%Y-%m-%d %H:%M")
    
    addWhitelistNameBox:SetText("")
    RefreshList()
    print(string.format(L.MSG_WHITELISTED, name))
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
        if string.sub(k, 1, 9) ~= "__CONFIG_" then
            table.insert(lines, "P^" .. k .. "^" .. (v.reason or "") .. "^" .. (v.time or ""))
        end
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
