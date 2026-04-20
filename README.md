# ylab

**前提：[GitHub Education](https://github.com/settings/education/benefits) の申請が通っている．**

他にコーディングエージェントを用意できるならそれを使ってもよい．Claude や ChatGPT の有料プランや，大学の GPGPU サーバを使ってもよいだろう．

## 準備

### 準備の準備

#### Windows

PowerShellで実行

WSL

```bash
wsl --install
```

Docker desktop

```
winget install Docker.DockerDesktop
```

Docker desktopを起動してから先に進む．

♠`docker pull` の匿名利用は，同一アドレスからの利用制限がある．制限に引っかかる場合は，Docker Hubのアカウントを作って，Docker desktopでログインする．

適当な作業フォルダを作る（例：`c:/work`）．

エクスプローラでそのフォルダを開き，アドレスバーに `bash` と入力すると，Ubuntu のターミナルが開く．（初回時はアカウント作成かもしれいない．パスワードは覚えやすく，入力しやすいものにする．）

**以下のコマンドを使う作業は全て Ubuntu のターミナルで行う．**

### Ubuntu（Windowsの場合はWSL）

必要なソフトウェアをインストールする．（`sudo` は管理者権限での実行．パスワード入力が必要）

```bash
sudo apt-get update && DEBIAN_FRONTEND=noninteractive sudo apt-get install -y curl bubblewrap gh git npm
```

GitHub Copilot CLI

```bash
npm install -g @github/copilot
```

動作確認（初回時はログインが必要．表示される8文字をブラウザに貼り付けて認証）

```bash
copilot
```

♠トークンを節約したい場合は，`/model` で軽いモデル（GPT-5.4 miniなど）を選ぶ．

### git

git の初期設定（ユーザ名とメアドを自分のもので置き換えて実行）

```bash
git config --global user.name "ユーザ名"
git config --global user.email メアド
git config --global core.autocrlf false
```

このリポジトリを clone する．

```
git clone https://github.com/taroyabuki/ylab.git
```

♠ファイルの更新には `git pull` で対応する．

## 練習

自分が PM 演習で作ったウェブアプリを再現できるように，練習.mdを編集して，Copilot に実行を指示する．♠`/plan`で計画を立ててから実行してもよい．

```
練習.mdを実行する．
```

以下を矢吹に見せて終了

- http://localhost でウェブアプリが動く．
- http://localhost/log.php でログが見える．
- draft.pdfがちょうど1ページ書けている．
