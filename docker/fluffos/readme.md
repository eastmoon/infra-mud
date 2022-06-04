# 編譯與啟動程序

FluffOS 是一套基於 MudOS 框架設計的遊戲驅動 ( Game Driver )，其設計重新整理 MudOS 停止釋出後這十年間累積的錯誤回報與效能提升，而繼承 LPMud 的設計原則，在建構服務時共有三個步驟：

+ 複製 mudlib
```
mkdir /app
cd /usr/src/fluffos/testsuite
cp -r . /app
```

+ 編譯 LDMud 遊戲驅動
```
mkdir /usr/src/fluffos/build
cd /usr/src/fluffos/build
cmake .. -DMARCH_NATIVE=OFF -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=/usr/local/mud
make install
```

+ 複製啟動設定檔
```
cp config.ini /app
```

完成上述程序後，FluffOS 會被安裝置預設位置 ```/usr/local/mud/``` 下，而 MUD 內容本體與驅動設定檔放置設定於 ```/app```，便可執行下述指令啟動服務

```
/usr/local/mud/bin/driver /app/config.ini
```
> MUD 啟動後對應的連接埠依據 config.ini 內設定所規劃
