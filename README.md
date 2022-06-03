# LDMud Server

本專案用於研究現存的 MUD 驅動系統，並以著名的 MUD 驅動建置容器化的編譯與執行環境

## LDMud

### 指令

本範例專案透過 ```ldmud.bat``` 封裝成 [CLI](https://github.com/eastmoon/command-line-interface-application) 工具。

+ 啟動服務
```
ldmud.bat up
```

+ 關閉服務
```
ldmud.bat down
```

### LDMud 編譯與啟動程序

LDMud 是一套基於 [LPC](https://mud.fandom.com/wiki/LPC) 框架 ( LPC 是基於 C 語言的物件導向框架 ) 設計的遊戲驅動 ( Game Driver )，而 MUD 內容本體則基於 LPC 撰寫並以此驅動運行；因此，在建構服務時共有兩個步驟：

+ 複製 mudlib
```
mkdir /app
cd /usr/src/ldmud/mud/lp-245
cp -r . /app
```

+ 編譯 LDMud 遊戲驅動
```
cd /usr/src/ldmud/src
./autogen.sh
./configure --libdir=/app
make install-all
```

完成上述程序後，LDMud 會被安裝置預設位置 ```/usr/local/mud/``` 下，而 MUD 內容本體放置設定於 ```/app```，便可執行下述指令啟動服務

```
/usr/local/mud/bin/ldmud 5000
```
> 5000 為 MUD 啟動後對應的連接埠

## 參考

+ [MUD](https://mud.fandom.com/wiki/MUD)
+ [LPC](https://mud.fandom.com/wiki/LPC)
    - [LPC Basics](https://www.cs.hmc.edu/~jhsu/wilderness/basics.html)
+ [LDMud - github](https://github.com/ldmud/ldmud)
    - [LDMud home page](http://www.ldmud.eu/)
    - [LDMud install document](https://github.com/ldmud/ldmud/blob/master/INSTALL)
    - [LDMud mudlib install document](https://github.com/ldmud/ldmud/tree/master/mud)
+ [TinTin++ Mud Client](https://tintin.mudhalla.net/download.php)
