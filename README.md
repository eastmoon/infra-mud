# MUD ( Multi-User Dungeon )

本專案用於研究現存的 MUD 驅動系統，並以著名的 MUD 驅動建置容器化的編譯與執行環境

專案範例環境如下：

+ Operating System : Linux ( Docker Container )
+ Language : C / C++

## 簡介

在電腦遊戲中，MUD ( Multi-User Dungeon ) 是以建置一個供多使用者登入的文字虛擬世界，常用於設計如角色扮演 ( role-player )、對戰遊戲 ( Hack and slash )、互動式小說 ( interactive fiction )、線上聊天 ( online chat )；而系統中，使用者可以透過趨向自然語言描述的指令取得系統的相應回饋，從閱讀描述、存取物品等。

由於 MUD 發展時期長，可追朔至 1978 年，以 Telnet 連線機制設計的 MUD1，時至今日就其遊戲類型會歸類至類大型多人線上角色扮演遊戲 ( MMORPG like )，但亦可說是 MMORPG 的概念原型；雖然 MUD 常用於設計取材於影視媒體的奇幻、科幻風格的角色扮演遊戲，但並沒所有皆為遊戲，其技術基礎是以 Telnet 連線的多人服務系統，因此也可以設計為 [MOO ( MUD, object oriented )](https://mud.fandom.com/wiki/MOO)，用於設計如教育用途、線上聊天、醫療系統等系統。

在 MUD 發展上，主要分為四個分支：

+ [AberMUD](https://mud.fandom.com/wiki/AberMUD)
+ [TinyMUD](https://mud.fandom.com/wiki/TinyMUD)
+ [LPMud](https://mud.fandom.com/wiki/LPMud)
+ [DikuMUD](https://mud.fandom.com/wiki/DikuMUD)

相關發展出的家族，可參考 [MUD famliy tree](https://mud.fandom.com/wiki/MUD_trees#TinyMUD_family_tree) 描述；由於 MUD 開發多為開源項目，且遊戲引擎發展迅速，常用語言也不斷變遷，可以注意到諸多 MUD 的最後版本在 2000 年前，直到近期才有部分 MUD 基於現在使用環境所需而改版；對此，本專案將調研周邊較多人討論的 LPMud 家族為主。

## LPMud

LPMud 是由 Lars Pensjö 於 1989 年發展出的分支，其中將其系統分成兩個部分：

+ Driver：MUD 環境與功能的虛擬機
+ Mudlib：基於 LPC 框架撰寫的世界構成元件

由於 Pensjö 對其最初設計，是著重於虛擬機，並將世界構成交由內容開發者 ( aka 巫師 ) 負責設計，因此發展出 C 語言為底的物件導向框架，讓內容開發者基於 LPC 來設計各類添加性的元素；也由於其設計方式，使得 LPMud 在 1990 年代初期，是最廣受推廣的 MUD 系統，其發展進程可用長尾效應來解釋 ( 引擎與內容區分，降低內容創作門檻 )。

### [LDMud](./docker/ldmud)

本範例專案透過 ```ldmud.bat``` 封裝成 [CLI](https://github.com/eastmoon/command-line-interface-application) 工具。

+ 啟動服務
```
ldmud.bat up
```

+ 關閉服務
```
ldmud.bat down
```

### [FluffOS](./docker/fluffos)

本範例專案透過 ```fluffos.bat``` 封裝成 [CLI](https://github.com/eastmoon/command-line-interface-application) 工具。

+ 啟動服務
```
fluffos.bat up
```

+ 關閉服務
```
fluffos.bat down
```

## 參考

+ [MUD](https://mud.fandom.com/wiki/MUD)
    - [MUD - wiki](https://zh.m.wikipedia.org/zh-tw/MUD)
+ [LPMud](https://mud.fandom.com/wiki/LPMud)
    - [LPC](https://mud.fandom.com/wiki/LPC)
        + [LPC Basics](https://www.cs.hmc.edu/~jhsu/wilderness/basics.html)
    - [LDMud - github](https://github.com/ldmud/ldmud)
        + [LDMud home page](http://www.ldmud.eu/)
        + [LDMud install document](https://github.com/ldmud/ldmud/blob/master/INSTALL)
        + [LDMud mudlib install document](https://github.com/ldmud/ldmud/tree/master/mud)
    - [FluffOS - github](https://github.com/fluffos/fluffos)
+ [Mudlib](https://mud.fandom.com/wiki/Mudlib)
    - [ES2 mudlib](https://github.com/MudRen/ES2-utf8)
+ [TinTin++ Mud Client](https://tintin.mudhalla.net/download.php)
+ 技術文章
    - [在Raspberry Pi上玩MUD遊戲](http://yehnan.blogspot.com/2021/07/raspberry-pimudfluffoseast-story-22.html)
