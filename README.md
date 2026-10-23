# ylab

この課題の進め方は次のとおりである．

- wslc で作成したコンテナを作業環境として使う．
- コンテナ内の作業用フォルダ `/root/work` は Windows の作業用フォルダと共有され，その中のファイルはエクスプローラでも確認できる．
- プログラムの作成や文書の組版などの作業は，コンテナ内のAI（Antigravity CLI）に任せる．

このフォルダの課題は，Windows の wslc で作成したコンテナ内で Antigravity CLI を使って実行する．**TeXテンプレートのレイアウトと枠組みは変更不可とし，文書はこのリポジトリの [checklist.md](checklist.md) を厳守する．** タイトル，学籍番号，氏名，本文など，テンプレートで記入を認められた箇所だけを編集する．

## 1 WSL のインストール・アップデート

管理者として PowerShell を開く．WSL が未インストールなら，次を実行し，再起動を求められたら Windows を再起動する．

```powershell
wsl --install --no-distribution
```

WSL をアップデートする．インストール済みの場合も，ここから実行する．

```powershell
wsl --update
wsl --version
wslc --help
```

インストール・アップデートでエラーになる場合や，更新後も `wslc` が見つからない場合は，[WSL の公式リリースページ](https://github.com/microsoft/WSL/releases/latest) の Assets から，PC に合った x64 または arm64 の `.msi` インストーラをダウンロードして実行する．再起動後，PowerShell を開き直して上の確認を行う．[WSL のコマンドの説明](https://learn.microsoft.com/windows/wsl/basic-commands)も参照できる．

## 2 作業用フォルダとコンテナの作成

空の作業用フォルダ（例：`C:\work`）を作り，エクスプローラで開く．アドレスバーに `powershell` と入力して Enter を押すと，そのフォルダで PowerShell が開く．次を実行してコンテナを作成する．

```powershell
wslc run -it -p 80:80 -v "$(pwd):/root/work" ubuntu.azurecr.io/ubuntu
```

イメージは `ubuntu.azurecr.io/ubuntu` とし，タグは指定しない．作業用フォルダはコンテナ内の `/root/work` にマウントされ，Windows のポート80がコンテナのポート80に接続される．以降の Bash コマンドは，開いたコンテナ内で実行する．

`-p 80:80` の左側は Windows 側，右側はコンテナ側のポート番号である．コンテナ内でウェブサーバを起動すると，Windows のブラウザから `http://localhost` で接続できる．ポートの接続設定だけではウェブサーバは起動しない．同じ Windows 側のポート80を複数のコンテナやアプリで同時に使うことはできないため，ポートが使用中というエラーが出たら，先に使っているコンテナやウェブサーバを確認して停止する．以前作成した課題用コンテナがある場合は，「7」の手順で再開する．

## 3 コンテナ内で Antigravity CLI をインストール

必要なソフトウェアと Antigravity CLI をインストールする．CLI の手順は[公式ドキュメント](https://www.antigravity.google/docs/cli/install/)を参照できる．

```bash
apt-get update
apt-get install -y ca-certificates curl git
curl -fsSL https://antigravity.google/cli/install.sh | bash
export PATH="$HOME/.local/bin:$PATH"
agy --version
```

続いて，マウントした空の作業用フォルダに課題を取得する．既に `/root/work/ylab` にこのリポジトリがある場合は，`git clone` を省略する．

```bash
cd /root/work
git clone https://github.com/taroyabuki/ylab.git
```

コンテナ内で次を実行し，`README.md`，`checklist.md`，`練習.md`，各原稿フォルダが表示されることを確認する．

```bash
ls /root/work/ylab
```

エクスプローラでも `C:\work\ylab` を開き，同じファイルとフォルダが見えることを確認する．これにより，コンテナ内の作業場所と Windows の作業用フォルダが共有されていることを確認できる．

既に原稿がある場合は，エクスプローラで `C:\work\ylab` を開き，中間審査概要は `中間審査概要`，卒業論文概要は `卒業論文概要`，卒業論文は `卒業論文` の各フォルダへコピーする．本文だけでなく，使用している図表や参考文献ファイルも対応する場所にコピーすること．作業用フォルダを `C:\work` 以外にした場合は，そのフォルダ内の `ylab` を使う．TeXテンプレートのレイアウトと枠組みは変更せず，既存原稿の設定が異なる場合は，本文など記入を認められた箇所だけを移す．

リポジトリは `/root/work/ylab` に作成される．CLI は `/root/work` で起動するため，以下のプロンプトではファイル名に `ylab/` を付ける．

## 4 起動・認証・動作確認

入力先は次の3種類である．コード欄の中身だけを，対応する入力先へ貼り付ける．

| 入力するもの | 入力先 | 画面の目安 |
| -- | -- | -- |
| `wsl`，`wslc` で始まるコマンド | Windows の PowerShell | `PS C:\work>` など |
| `apt-get`，`cd`，`git`，`ls`，`agy` などの Bash コマンド | コンテナ内の Bash | `root@…:…#` など |
| 「ylab/練習.mdを実行」などの日本語のプロンプト | 起動した Antigravity CLI | 対話用の入力欄 |

Antigravity CLI の実行中に Bash コマンドを自分で実行する場合は，Ctrl+Cを2回押して CLI を終了してから入力する．

コンテナ内で，必ず作業用フォルダへ移動してから起動する．

```bash
cd /root/work
agy --dangerously-skip-permissions
```

`--dangerously-skip-permissions` は操作の承認確認を省略する．コンテナ内で自己責任で使用すること．マウントした作業用フォルダの変更・削除は Windows 側にも反映される．

初回起動時は，次の順に認証と初期設定を行う．**大学の Google アカウントで認証すること．**

1. 「Select login method:」で「1. Google OAuth」を選択する．
1. URLが表示されたら，Ctrlを押しながら「Click here to authenticate」をクリックし，Windows のブラウザで開く．
1. ブラウザで大学の Google アカウントを選択してログインする．
1. 表示されたコードをクリップボードにコピーする．
1. PowerShell のウィンドウに戻り，Antigravity CLI の認証コード入力欄に Ctrl+V で貼り付け，Enterを押す．
1. 「Choose your color scheme:」で好きな配色を選ぶ．
1. 「Terms of Service & Data Use」の内容を確認し，Enterで選択する．カーソルキーで `[Done]` を選択してEnterを押す．
1. 「Do you trust the contents of this project?」で「Yes」を選択してEnterを押す．

入力できる状態になったら，次の日本語のプロンプトを Antigravity CLI に入力する．

```text
現在の作業フォルダを確認し，ylab/README.md，ylab/練習.md，ylab/checklist.md を読んで，課題と遵守事項を要約して．まだファイルは変更しないで．
GitHub上のオリジナル（https://github.com/taroyabuki/ylab）の対応するTeXテンプレートを取得して比較し，レイアウト設定と枠組みが変わっていないことを確認して．タイトル，学籍番号，氏名，本文など記入を認められた箇所の違いは除き，レイアウトに関わる差分があれば報告して．取得できない場合は確認済みとせず，未確認であることを報告して．
```

作業フォルダが `/root/work` であり，課題の内容，TeXテンプレートの変更禁止，checklist.md の厳守について返答が得られることを確認する．

Antigravity CLI を終了するときは，Ctrl+Cを2回押す．コンテナ内の Bash に戻るので，シェルのコマンドはそこで実行する．さらに `exit` を実行すると Windows の PowerShell に戻る．作業の再開方法は「7 コンテナでの作業を再開」を参照する．

## 5 練習

[練習.md](練習.md)を読んで内容を確認してから，起動した Antigravity CLI に次を指示する．

```text
ylab/練習.mdを実行．課題内の相対パスは /root/work/ylab を基準に扱うこと．TeXテンプレートのレイアウトと枠組みは変更せず，ylab/checklist.md の全項目を厳守し，完成後に照合して．
GitHub上のオリジナル（https://github.com/taroyabuki/ylab）の対応するTeXテンプレートを取得して比較し，レイアウト設定と枠組みが変わっていないことを確認して．タイトル，学籍番号，氏名，本文など記入を認められた箇所の違いは除き，レイアウトに関わる差分があれば報告して．取得できない場合は確認済みとせず，未確認であることを報告して．
```

完成したら，Windows のブラウザと作業用フォルダで次を確認する．

- http://localhost でウェブアプリが動く．
- http://localhost/log.php でログが見える．
- `ylab/www-report/draft.pdf` がちょうど1ページで書けている．
- TeXテンプレートのレイアウトと枠組みが保たれ，checklist.md の全項目を満たしている．

## 6 卒論の執筆

組版は，以下のプロンプトを Antigravity CLI に入力して行う．必要な TeX 環境のインストールと組版は，CLI に現在のコンテナ内で直接実行させる．

中間審査概要，卒業論文概要，卒業論文は執筆時期が異なる．必要な時期に，対象のプロンプトだけを Antigravity CLI に入力してテンプレートをビルドする．

### 中間審査概要

中間審査概要を組版するときは，次を指示する．

```text
ylab/checklist.md を読み，ylab/中間審査概要/draft.tex をビルドして，ylab/中間審査概要/draft.pdf を作成して．
必要な TeX 環境を現在のコンテナ内にインストールし，ylab/中間審査概要/ の既存の latexmkrc を使って，コンテナ内で直接組版すること．
TeXテンプレートのレイアウトと枠組みは変更しない．本文や参考文献を創作せず，ビルド結果と未解決の警告を報告して．
GitHub上のオリジナル（https://github.com/taroyabuki/ylab）の対応するTeXテンプレートを取得して比較し，レイアウト設定と枠組みが変わっていないことを確認して．タイトル，学籍番号，氏名，本文など記入を認められた箇所の違いは除き，レイアウトに関わる差分があれば報告して．取得できない場合は確認済みとせず，未確認であることを報告して．
```

Windows の作業用フォルダ内の `ylab/中間審査概要/draft.pdf` を開いて確認する．

### 卒業論文概要

卒業論文概要を組版するときは，次を指示する．

```text
ylab/checklist.md を読み，ylab/卒業論文概要/draft.tex をビルドして，ylab/卒業論文概要/draft.pdf を作成して．
必要な TeX 環境を現在のコンテナ内にインストールし，ylab/卒業論文概要/ の既存の latexmkrc を使って，コンテナ内で直接組版すること．
TeXテンプレートのレイアウトと枠組みは変更しない．本文や参考文献を創作せず，ビルド結果と未解決の警告を報告して．
GitHub上のオリジナル（https://github.com/taroyabuki/ylab）の対応するTeXテンプレートを取得して比較し，レイアウト設定と枠組みが変わっていないことを確認して．タイトル，学籍番号，氏名，本文など記入を認められた箇所の違いは除き，レイアウトに関わる差分があれば報告して．取得できない場合は確認済みとせず，未確認であることを報告して．
```

Windows の作業用フォルダ内の `ylab/卒業論文概要/draft.pdf` を開いて確認する．

### 卒業論文

卒業論文を組版するときは，次を指示する．

```text
ylab/checklist.md を読み，ylab/卒業論文/draft.tex をビルドして，ylab/卒業論文/draft.pdf を作成して．
必要な TeX 環境を現在のコンテナ内にインストールし，ylab/卒業論文/ の既存の latexmkrc を使って，コンテナ内で直接組版すること．
TeXテンプレートのレイアウトと枠組みは変更しない．本文や参考文献を創作せず，ビルド結果と未解決の警告を報告して．
GitHub上のオリジナル（https://github.com/taroyabuki/ylab）の対応するTeXテンプレートを取得して比較し，レイアウト設定と枠組みが変わっていないことを確認して．タイトル，学籍番号，氏名，本文など記入を認められた箇所の違いは除き，レイアウトに関わる差分があれば報告して．取得できない場合は確認済みとせず，未確認であることを報告して．
```

Windows の作業用フォルダ内の `ylab/卒業論文/draft.pdf` を開いて確認する．

執筆時は，研究内容や結果を CLI に伝え，AIにTeXファイルを編集させてもよい．編集は，タイトル，学籍番号，氏名，本文など，記入を認められた箇所に限る．**TeXテンプレートのレイアウトと枠組みは変更不可とし，このリポジトリの checklist.md の全項目を厳守すること．**

### ヒント：論文を背景と参考文献に追加する

参考にしたい論文のURLやPDFファイル名を指定すると，背景への概要追加と文献リストへの登録も依頼できる．PDFは作業用フォルダに置き，次の `<…>` を対象の原稿と論文に置き換えて指示する．

```text
ylab/checklist.md に従い，<論文のURLまたはPDFファイルのパス> を読んで，研究との関係が分かるように概要を <対象の原稿フォルダ> の背景に追加して．BibTeXに書誌情報を登録し，本文で引用して文献リストに加えて．論文の内容や書誌情報を推測で補わず，取得・確認できない場合は報告して．TeXテンプレートのレイアウトと枠組みは変更せず，GitHub上のオリジナル（https://github.com/taroyabuki/ylab）と比較して確認し，組版して．
```

### 補足：VS Code で原稿とPDFを確認する

VS Code に拡張機能 [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) を入れると，PDFを開きながら，[SyncTeX](https://github.com/James-Yu/LaTeX-Workshop/wiki/View) で原稿とPDFの対応する箇所を行き来できて便利である．使いたい場合は，AI（Antigravity CLI）に聞きながら設定すること．その際は，組版を wslc のコンテナ内で行い，Windows 側の VS Code で共有フォルダを開いていることを伝える．

### 研究発表用のポスター

中間審査概要と卒業論文を基に，標準的な研究発表用ポスターを作成する．Antigravity CLI に次を指示する．

```text
ylab/中間審査概要/ と ylab/卒業論文/ を参照し，A0縦1ページの標準的な研究発表用ポスターを作成して．内容が異なる場合は卒業論文を優先し，結果や文献を創作しないこと．
ylab/checklist.md を厳守し，現在のコンテナ内で組版して，ソースと poster.pdf を ylab/poster/ に保存し，読みやすさと文字切れを確認して．
参照元の文書は変更しないこと．
```

作成した `ylab/poster/poster.pdf` を開き，内容と読みやすさを確認する．

### 研究発表用のスライド

卒業論文概要と卒業論文を基に，標準的な研究発表用スライドを作成する．Antigravity CLI に次を指示する．

```text
ylab/卒業論文概要/ と ylab/卒業論文/ を参照し，画面比率16:9，発表時間10分の標準的な研究発表用スライドと説明原稿を作成して．内容が異なる場合は卒業論文を優先し，結果や文献を創作しないこと．
ylab/checklist.md を厳守し，現在のコンテナ内で組版して，ソース，slides.pdf，説明原稿を ylab/slides/ に保存し，読みやすさ，文字切れ，発表時間を確認して．
参照元の文書は変更しないこと．
```

作成した `ylab/slides/slides.pdf` を開き，説明原稿を使ってリハーサルを行い，発表時間10分に収まるように調整する．

## 7 コンテナでの作業を再開

コンピュータを再起動するとコンテナは停止する．作業用フォルダをエクスプローラで開き，アドレスバーに `powershell` と入力して PowerShell を開く．次のコマンドで，以前作成したコンテナのIDを確認する．

```powershell
wslc ps -a
```

一覧のイメージ名 `ubuntu.azurecr.io/ubuntu` と作成時刻から対象を確認する．`<コンテナID>` をそのIDに置き換えて，そのコンテナを起動し，シェルに入る．再開時は `wslc run` で新しいコンテナを作成しない．

```powershell
wslc start <コンテナID>
wslc exec -it <コンテナID> bash
```

例えば，`wslc ps -a` で確認したIDが `a1b2c3d4e5f6` なら，次のように入力する．このIDは説明用なので，実際に表示されたIDを使うこと．`<` と `>` は入力しない．既に実行中なら `wslc start` は省略する．

```powershell
wslc start a1b2c3d4e5f6
wslc exec -it a1b2c3d4e5f6 bash
```

コンテナ内で，作業用フォルダに移動し，Antigravity CLI を再び起動する．インストール済みのソフトウェアと作業ファイルは引き続き使える．認証を求められたら，画面の案内に従う．

```bash
export PATH="$HOME/.local/bin:$PATH"
cd /root/work
agy --dangerously-skip-permissions
```

ウェブアプリも使う場合は，CLI にコンテナ内の Apache を起動させ，Windows のブラウザで http://localhost を確認する．

## 8 卒論完了後のコンテナ削除

卒論に関する作業が全て終わったら，成果物が Windows の作業用フォルダ内の `ylab/` に保存されていることを確認する．コンテナ内だけに保存した必要なファイルがあれば，削除前に `/root/work` 以下へコピーする．

Ctrl+Cを2回押して CLI を終了し，コンテナのシェルで `exit` を実行して PowerShell に戻る．次のコマンドでコンテナのIDを確認する．

```powershell
wslc ps -a
```

`<コンテナID>` を卒論で使用したコンテナのIDに置き換え，実行中なら停止してから削除する．既に停止している場合は `wslc stop` を省略する．

```powershell
wslc stop <コンテナID>
wslc rm <コンテナID>
```

例えば，対象のIDが `a1b2c3d4e5f6` で実行中なら，`wslc stop a1b2c3d4e5f6`，`wslc rm a1b2c3d4e5f6` の順に実行する．説明用のIDをそのまま使わず，自分のコンテナのIDに置き換えること．

コンテナを削除しても，マウントした Windows の作業用フォルダと，その中の成果物は残る．コンテナの操作は [WSL containers の公式ガイド](https://learn.microsoft.com/windows/wsl/tutorials/wsl-containers)も参照できる．
