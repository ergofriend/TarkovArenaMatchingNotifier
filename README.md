This project is based on [advancedbear/TarkovSpawnNotifier: Notify when your matching completed.](https://github.com/advancedbear/TarkovSpawnNotifier)

# EFT:Arena Matching Notifier

マッチングの承認とプリセットの選択を行うタイミングでトースト通知を送ります。

マッチング音に耳を済ませたり、プリセット選択画面になるまで何分も待機する必要はもうありません。

<br />

Accepting a match and Selecting a preset will send toast notifications.

No more listening to the matching sound or waiting minutes for the preset selection screen.

<br />

https://github.com/user-attachments/assets/fe0a94e6-a642-448f-9760-a581a5f49d0f


# How To Use (JP)
1. [TarkovArenaMatchingNotifier.zip](https://github.com/ergofriend/TarkovArenaMatchingNotifier/archive/refs/heads/main.zip)をダウンロードし、展開します。
2. `TarkovArenaMatchingNotifier.ps1` をメモ帳などで開き、以下の行を編集します。
    ```PowerShell
    $path = "C:\Battlestate Games\Escape from Tarkov Arena\Logs"
    ```
    EFT:Arenaをインストールしたパスを書いて上書き保存してください。
3. EFT:Arenaの起動が完了した後、`start.bat`をダブルクリックして開始します。
    - PowerShellスクリプトを初めて使う場合、「実行ポリシーの変更」画面が表示されます。
    - [Y]キーを押して、変更を許可してください。
4. `Activated` が表示されれば、動作が開始しています！
    - マッチメイキング完了時に、バルーン通知が表示されます。
    - アプリを開いて「Accept」を押してください。

# How To Use (EN)
1. Download [TarkovArenaMatchingNotifier.zip](https://github.com/ergofriend/TarkovArenaMatchingNotifier/archive/refs/heads/main.zip) and Extract it..
2. Open `TarkovArenaMatchingNotifier.ps1` with Notepad and Edit as below.
    ```PowerShell
    $path = "C:\Battlestate Games\Escape from Tarkov Arena\Logs"
    ```
    Over-Write your EFT:Arena installed Path in this line.
3. Execute `start.bat` after launched "Escape from Tarkov".
    * When it's first time to use PowerShell Script, "Execution Policy Change" prompt will be shown.
    * Press [Y] key and Accept the execution policy.
4. When you can see `Activated`, it's Working!
    * When match making is finished, Baloon notification will be shown.
    * Open app and click "Accept".

# 注意 / Disclaimer
- 本ツールは、EFT:Arena がデフォルトで出力している `web_socket.log` を読み取って出力しています。
- This tool read EFT:Arena default log `web_socket.log` for monitoring match making.
- ゲーム本体に対しては何も操作を行いませんが、本ツールを利用したことによるいかなる損害についても作者はその責を負いません。
- This tool does NOT affect the game in any way, but the author is not responsible for ANY damage that may occur.
- `start.bat`で開いたウィンドウ（Activateが書いてあるやつ）を閉じたら動きません（あたりまえ）
- DON'T CLOSE THE WINDOW WHICH ONE OPENED BY `start.bat`!!!!

# License
MIT

# Contact
[@ergofriend](https://twitter.com/ergofriend) or [Issues](https://github.com/ergofriend/TarkovArenaMatchingNotifier/issues)
