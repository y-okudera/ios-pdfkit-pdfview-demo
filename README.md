# PDFView

## 概要
PDFViewは、アプリ内でPDFビューアーを管理するクラスです。
Interface Builderを使用して生成可能です。

## 関連クラス
PDFDocument
PDFThumbnailView
　
## 実装手順
1. StoryboardにUIViewを配置します。
2. UIViewのCustom ClassにPDFViewを設定します。
3. UIViewControllerとStoryboardのPDFViewを関連付けます。
4. PDFViewにPDFDocumentオブジェクトをセットして画面に表示させます。

## 主要プロパティ

|プロパティ名|説明|サンプル|
|---|---|---|
|document | PDFViewオブジェクトに<br>関連付けられたドキュメントを取得する | pdfView.document |
|autoScales | 初期表示が画面サイズに<br>ピッタリ収まるようにするかどうか | pdfView.autoScales = true |
|displaysPageBreaks | 余白を表示するかどうか | pdfView.displaysPageBreaks = true |
|pageBreakMargins | 余白を設定する | pdfView.pageBreakMargins =<br>    UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0) |
|backgroundColor | 背景色を設定する | pdfView.backgroundColor = .lightGray |
|displayDirection | スクロールの方向を設定する | pdfView.displayDirection = horizontal |
|displayMode | 表示モードを設定する | pdfView.displayMode = .singlePage |
|displaysAsBook | 見開きの時に最初のページを<br>表紙として使用するかどうか | pdfView.displaysAsBook = true |

## 主要メソッド

|メソッド名|説明|サンプル|
|---|---|---|
|canGoToNextPage() | 次のページに移動可能かどうか判定する | pdfView.canGoToNextPage() |
|goToNextPage(_:) | 次のページに移動する | pdfView.goToNextPage(sender) |
|canGoToPreviousPage() | 前のページに移動可能かどうか判定する | pdfView.canGoToPreviousPage() |
|goToPreviousPage(_:) | 前のページに移動する | pdfView.goToPreviousPage(sender) |
|usePageViewController(_:withViewOptions:) | pageViewControllerを利用する | pdfView.usePageViewController(true) |

## フレームワーク
PDFKit.framework

## サポートOSバージョン
iOS11.0以上

## 開発環境
|category | Version|
|---|---|
| Swift | 4.0 |
| XCode | 9.0 |
| iOS | 11.0〜 |

## 参考
https://developer.apple.com/documentation/pdfkit/pdfview
