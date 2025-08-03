SNESSDK - Super Nintendo Development Kit / スーパーファミコン開発キット

SNESSDK is a lightweight SDK for developing SNES (Super Famicom) homebrew using C and 65816 assembly.
SNESSDK は、C言語と65816アセンブリでスーパーファミコン（SNES）の自作ソフトを開発するための軽量なSDKです。

🚀 How to Build a ROM / ROMの作り方

▶ Just run CreateROM.bat inside the snesc folder.

▶ snesc フォルダ内の CreateROM.bat を実行するだけで、ROMが生成されます。

Steps:

Open a command prompt and go to the project folder:

コマンドプロンプトでプロジェクトフォルダへ移動：

cd snesc
CreateROM.bat

The script does everything automatically.
このバッチファイルがすべて自動で行います。

🔧 What CreateROM.bat Does / 処理内容の概要

Enters snesc/ directory / snesc/ フォルダに移動

Converts .ps to .s with 816-opt.py / .ps ファイルを .s に変換

Assembles main.asm using wla-65816 / アセンブリ化

Links to .sfc ROM with wlalink / ROM生成

Returns to original folder / 元の場所へ戻る

Generated ROM: main.sfc → Can be opened with SNES emulators
生成されたROMファイル：main.sfc → SNESエミュレータで動作可能

📁 Project Structure / プロジェクト構成

bin/       - Tools (816-opt.py, etc.) / ツール類
snesc/     - C-like source files + CreateROM.bat / C風ソースとビルド
snesasm/   - Pure assembly demos / アセンブリデモ
lib/       - Header & macro files / ヘッダー・マクロ

🛠 Requirements / 動作環境

Windows PC (recommended) / Windows（推奨）

Python 3.x (used by 816-opt.py)

WLA-DX assembler and wlalink

SNES Emulator (e.g. SNES9x, bsnes)

✅ Features / 主な機能

Hybrid C and 65816 ASM development / CとASMのハイブリッド開発

Background scrolling demo / 背景スクロールのデモ

Sprite drawing / スプライト描画

Text & tile graphics support / テキストとタイル表示対応

Readable and modifiable / 読みやすく改造しやすいコード

📦 License / ライセンス

This project is released under the MIT License. You are free to use and modify it.
MITライセンスで公開しています。自由に利用・改造できます。

🧑‍💻 Contact / コンタクト

Feel free to fork, report issues, or contribute.
フォーク・バグ報告・改善提案など歓迎です！

開発者コミュニティやSFCファンの方々と共有していただけると嬉しいです。

🎮 Enjoy SNES development!

スーパーファミコン開発を楽しみましょう！

