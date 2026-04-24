# ylab

コーディングエージェントの準備をする．

選択肢

エージェント|メモ
--|--
Copilot CLI|[GitHub Education](https://github.com/settings/education/benefits) の申請が通れば無料で使える．
Gemini CLI|Google アカウントで無料で使える．
Qwen Code|研究室のサーバ（Qwen3.6-27B）．研究室内限定．同時利用1人
Codex CLI|ChatGPT Plusが必要，有料
Claude Code|Claude Proが必要，有料
大学のGPGPUサーバ|授業使用中は連続使用は15分まで．この中では最も設定が難しい．

Codex，Claude Code，大学のGPGPUサーバについてはここでは書かない．

## 準備

Ubuntu の場合を説明する．Windows なら，WSL をインストールすればよい．

### Windows での準備

```bash
# PowerShell で次を実行し，WSL をインストールする．
wsl --install
```

適当な作業フォルダを作る（例：`c:/work`）．

エクスプローラでそのフォルダを開き，アドレスバーに `bash` と入力すると，Ubuntu のターミナルが開く．（初回時はアカウント作成かもしれいない．パスワードは覚えやすく，入力しやすいものにする．）

#### Docker


```bash
# （Windowsの場合）Docker desktop をインストールする．
winget install Docker.DockerDesktop
```

Docker desktopを起動してから先に進む．

♠`docker pull` の匿名利用は，同一アドレスからの利用制限がある．制限に引っかかる場合は，Docker Hubのアカウントを作って，Docker desktopでログインする．

### Ubuntu での作業


```bash
# 最新の nodejs を入れる．（`sudo` は管理者権限での実行．パスワード入力が必要）
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs
```

```bash
# その他，必要なソフトウェアをインストールする．
sudo apt-get update && DEBIAN_FRONTEND=noninteractive sudo apt-get install -y build-essential ca-certificates curl bubblewrap fd-find gh git ripgrep
```

```bash
# git の初期設定（ユーザ名とメアドを自分のもので置き換えて実行）
git config --global user.name "ユーザ名"
git config --global user.email メアド
git config --global core.autocrlf false
```

### クライアント

♠起動時にオプション `--yolo` を付けると全自動になるが，危険である．コンテナか sandbox の使用を検討すること．

#### （選択肢1）Copilot

```bash
# インストール
sudo npm install -g @github/copilot
```

```bash
# 起動（初回時はログインが必要．表示される8文字をブラウザに貼り付けて認証）
copilot
# Ctrl-C, C で終了
```

♠トークンを節約したい場合は，`/model` で軽いモデル（GPT-5.4 miniなど）を選ぶ．

#### （選択肢2）Gemini CLI

```bash
# インストール
sudo npm install -g @google/gemini-cli
```

```bash
# 起動（初回時はログインが必要．ブラウザで認証する．）
gemini
# Ctrl-C, C で終了．
```

#### （選択肢3）研究室のサーバ（Qwen3.6-27B．研究室LAN限定．同時利用1人）

```bash
# インストール
sudo npm install -g @qwen-code/qwen-code@latest
```

```bash
# 起動
qwen \
  --auth-type openai \
  --openai-base-url "http://10.100.192.10:8080/v1" \
  --openai-api-key "076f9a9ebdf33be7f450d30b96c90b9ee686155cba6d2ad7" \
  --model qwen3.6-27b
# Ctrl-C, C で終了．
```

## 練習

このリポジトリを clone して，その中で作業する．

```bash
git clone https://github.com/taroyabuki/ylab.git
cd ylab
```

♠ファイルの更新には `git pull` で対応する．そこでエラーになる場合は，エージェントに対応させればよい．**checklist.md は常に最新版を使うこと．**

上述の方法で，何らかのコーディングエージェントを起動する．

### 1 基本

練習.mdを読んで，やりたいことを確認してから，エージェントに実行を指示する．♠`/plan`で計画を立ててから実行してもよい．

```
練習.mdを実行
```

- http://localhost でウェブアプリが動く．
- http://localhost/log.php でログが見える．
- draft.pdfがちょうど1ページ書けている．

### 2 応用

PM 演習で作ったウェブアプリを再現し，説明文書を書く．

以下を矢吹に見せたら，コンテナを削除して終了する．コンテナの削除はエージェントにやらせてもよい．イメージはないはずだが，作っていたらそれも削除する．

- http://localhost でウェブアプリが動く．
- draft.pdfがちょうど1ページ書けている．
