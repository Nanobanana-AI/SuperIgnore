<div align="center">
  <h1>🚫 SuperIgnore</h1>
  <p><b>The Ultimate Account-wide Ignore System for WoW</b></p>
  <p>魔兽世界全战网通用黑名单插件</p>
  
  [![GitHub Release](https://img.shields.io/github/v/release/Nanobanana-AI/SuperIgnore?style=for-the-badge&logo=github)](https://github.com/Nanobanana-AI/SuperIgnore/releases)
  [![CurseForge](https://img.shields.io/badge/CurseForge-F16436?style=for-the-badge&logo=curseforge&logoColor=white)](https://www.curseforge.com/wow/addons/superignore)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
  [![WoW Version](https://img.shields.io/badge/WoW-Retail-blue?style=for-the-badge&logo=worldofwarcraft)](https://worldofwarcraft.blizzard.com/)
</div>

---

## 📖 Introduction (简介)

**SuperIgnore** is a lightweight, high-performance addon designed to provide a comprehensive ignore system that works across the entire Battle.net account. It helps you block players across all characters and filter annoying chat messages with ease.

**超级黑名单**是一个极简、轻量、高性能的聊天过滤与黑名单管理插件，旨在提供一套覆盖整个战网账号的全面屏蔽系统。

> **一次拉黑，全战网所有角色共同生效！还你清净的艾泽拉斯！**

---

## 🚀 Key Features (核心功能)

* **Account-wide Ignore / 账号通用黑名单:** Block players across all your characters. Once a player is added to the SuperIgnore list, they will be blocked on all your characters.
  *跨角色屏蔽，一次添加，全账号所有角色生效，无需重复拉黑。*

* **Smart Filtering / 智能聊天过滤:** Supports regex and keyword-based filtering to block annoying chat messages (e.g., boosting, advertising). Advanced filters can mute AFK/DND spam, repeated messages, and achievement spam.
  *支持正则与关键词模糊匹配，并内置多种智能过滤器（如暂离拦截、防刷屏、防霸屏），强力拦截垃圾信息。*

* **Whitelist System / 专属白名单系统:** Easily exempt trusted players (like crafters) from filters via the right-click menu, preventing accidental blocks.
  *支持右键一键添加白名单，豁免暂离等过滤规则，彻底告别公益工匠误伤。*

* **Intelligent Auto-decline / 智能拦截:** Automatically declines group invitations and trade requests from blacklisted players.
  *自动拒绝黑名单玩家的组队邀请与交易请求。*

* **Cross-realm Support / 跨服精准支持:** Accurately identifies and blocks players even when they are from different realms, with automatic server name verification.
  *精准识别跨服玩家，支持自动服务器名称补全与校验。*

* **Easy Data Management / 便捷数据管理:** Import and export your blacklist effortlessly using structured data code.
  *支持通过代码轻松导入或导出你的黑名单数据，方便备份与分享。*

---

## 🌍 Region Compatibility (区域兼容性说明)

The core features (Account-wide ignore, chat filtering, auto-decline) work perfectly on **ALL** regional servers (NA/EU/Asia).
*插件基础核心功能：右键拉黑、跨角色、拦截等，全球服务器通用。*

> **Note / 注意:** The "Meeting Stone Sync" feature is specifically designed for the CN region's NetEase Meeting Stone addon.
> *自动同步集合石功能仅对国服客户端生效。*

---

## 📖 How to Use (使用方法)

* 🖱️ **In-game Menu / 游戏内菜单:** 
  Right-click on a player's character portrait or name in chat to add them to your SuperIgnore list or Whitelist.
  *在目标头像或聊天框右键点击玩家名称，即可快捷将其加入超级黑名单或白名单。*

* ⌨️ **Slash Commands / 呼出指令:** 
  Type `/si`, `/sig`, or `/superignore` in the chat to open the configuration panel. Here you can manage your blocked players, keywords, whitelist, smart filters, and data sync settings.
  *(Note: If `/si` conflicts with other addons, please use `/sig`)*
  *在聊天框输入 `/si`、`/sig` 或 `/superignore` 即可打开配置面板。您可以在此面板中便捷地管理黑白名单、屏蔽词、智能过滤选项以及进行数据同步。*
  *（注：若 `/si` 与其他插件产生冲突失效，请使用备用指令 `/sig`）*

---

## 📝 Changelog (更新日志)

### 🌟 v1.3.0 - (2026.07.06)


* ✨ **New Smart Filters:** Introduced 5 intelligent chat filters to drastically clean up your chat window. You can now block messages from DND/AFK players (applies to Whisper, Say, Yell, Party, and Raid channels), prevent repeat message spam, merge duplicate guild/party achievements, mute repetitive NPC dialogues, and hide trivial quest progress announcements.
* 🛡️ **New Whitelist System & UI:** Added dedicated "Filters" and "Whitelist" tabs to the options panel. You can now easily exempt trusted players (like crafters) from the DND/AFK filter via the right-click menu or the new interface.
* 🔧 **Compatibility Improvements:** Added alternative slash commands (`/sig` and `/superignore`) to seamlessly resolve command conflicts with other popular addons (such as *SavedInstances*).


* ✨ **全新智能过滤器：** 重磅上线 5 大实用聊天过滤功能！支持一键拦截“暂离/忙碌”状态玩家的发言（包含私聊、说、大喊、小队、团队频道），过滤重复刷屏信息、智能合并多人同款成就防霸屏、屏蔽 NPC 重复啰嗦台词，以及过滤毫无意义的队伍任务进度通告。
* 🛡️ **白名单系统与面板升级：** 设置面板新增专属的“扩展过滤”与“白名单”独立页签。现在你可以通过右键菜单，快捷将信任的玩家（如公益工匠）加入白名单，使其无视暂离拦截规则，彻底告别误伤！
* 🔧 **兼容性优化：** 完美解决了与 *SavedInstances* 等热门插件的斜杠命令冲突问题，新增 `/sig` 和 `/superignore` 作为备用呼出指令，使用更加顺畅。

---

### 🌟 v1.2.0 - (2026.07.05)


* 🌐 **Localization Support:** Added full multi-language support (Simplified Chinese, Traditional Chinese, English). The addon now automatically adapts to your game client's language across all regional servers.


* 🌐 **多语言支持：** 新增全面的多语言支持（简体中文、繁体中文、英文），全自动无缝适配全球各区域服务器的客户端语言设置。

---

### 🌟 v1.1.0 - (2026.07.05)


* ✨ **New Feature:** Added one-click and automatic sync with the NetEase Meeting Stone ignore list. Converts your temporary group-finder ignores into permanent, account-wide blacklists.
* ⚡ **Optimization:** Improved data cleaning logic to enhance cross-realm matching accuracy.
* 🎨 **UI Polish:** Added a dedicated "About" tab and real-time data statistics.


* ✨ **新增功能：** 新增一键全自动同步网易集合石黑名单功能，将您在集合石屏蔽的玩家账号，瞬间转化为永久的战网通用黑名单。
* ⚡ **底层优化：** 优化底层数据清洗逻辑，提升跨服匹配精度。
* 🎨 **界面升级：** 新增“关于”独立页签与实时数据统计显示。

---

## ⬇️ Download & Install (下载与安装)

[![CurseForge](https://img.shields.io/badge/CurseForge-Official_Page-F16436?style=for-the-badge&logo=curseforge&logoColor=white)](https://www.curseforge.com/wow/addons/superignore)

🔗 [CurseForge 官方页面直达](https://www.curseforge.com/wow/addons/superignore)



<img width="815" height="820" alt="1" src="https://github.com/user-attachments/assets/2b67183b-06b4-4f25-9dbf-b34e788b1d20" />
<img width="812" height="819" alt="2" src="https://github.com/user-attachments/assets/274ad1d0-7ab0-4f01-a24a-fbce5912f616" />
<img width="812" height="822" alt="3" src="https://github.com/user-attachments/assets/b568429d-1d6f-47f5-81e2-700d0e21040d" />
<img width="816" height="814" alt="4" src="https://github.com/user-attachments/assets/0e77c935-3cd6-499b-8551-1656f53e4c35" />













