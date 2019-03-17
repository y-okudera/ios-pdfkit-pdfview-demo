//
//  PDFViewer.swift
//  ios-pdfkit-pdfview-demo
//
//  Created by YukiOkudera on 2019/03/17.
//  Copyright © 2019 OkuderaYuki. All rights reserved.
//

import PDFKit
import UIKit

final class PDFViewer: NSObject {
    
    private(set) var pdfView: PDFView?
    private var pdfUrl: URL?
    private var pdfData: Data?
    private var pdfPath: String?
    private var localPDFName: String?
    
    init(frame: CGRect, pdfUrl: URL) {
        self.pdfView = PDFView(frame: frame)
        self.pdfUrl = pdfUrl
    }
    
    init(frame: CGRect, pdfData: Data) {
        self.pdfView = PDFView(frame: frame)
        self.pdfData = pdfData
    }
    
    init(frame: CGRect, pdfPath: String) {
        self.pdfView = PDFView(frame: frame)
        self.pdfPath = pdfPath
    }
    
    init(frame: CGRect, localPDFName: String) {
        self.pdfView = PDFView(frame: frame)
        self.localPDFName = localPDFName
    }
    
    func show() {
        
        if let pdfUrl = self.pdfUrl {
            showPDF(pdfUrl: pdfUrl)
            return
        }
        
        if let pdfData = self.pdfData {
            showPDF(pdfData: pdfData)
            return
        }
        
        if let pdfPath = self.pdfPath {
            showPDF(pdfPath: pdfPath)
            return
        }
        
        if let pdfName = self.localPDFName {
            showPDF(pdfName: pdfName)
            return
        }
        assertionFailure("Could not read pdf.")
    }
    
    /// PDFViewの初期処理をする
    func setupPdfView() {
        guard let pdfView = self.pdfView else {
            return
        }
        
        // 初期表示が画面サイズにピッタリ収まるようにする
        pdfView.autoScales = true
        
        // 余白を消す
        // pdfView.displaysPageBreaks = false
        
        // 余白を設定する
        pageBreakMargins(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        // 背景色を設定
        pdfView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.8, alpha: 1)
        
        // スクロール方向に縦向きを設定
        displayDirection(direction: .vertical)
        
        displayMode(mode: .singlePageContinuous)
    }
}

// MARK: - Show PDF
extension PDFViewer {
    
    /// ローカルのPDFのファイル名を指定して、画面に表示する
    ///
    /// - Parameter pdfName: foo.pdfの場合 -> foo
    private func showPDF(pdfName: String, usePageViewController: Bool = false) {
        if let pdfPath = Bundle.main.path(forResource: pdfName, ofType: "pdf") {
            showPDF(pdfPath: pdfPath, usePageViewController: usePageViewController)
        }
    }
    
    /// PATHを指定して、PDFを表示する
    ///
    /// - Parameters:
    ///   - pdfPath: PDFファイルのPATH
    ///   - usePageViewController: trueの場合pageViewControllerを利用する
    private func showPDF(pdfPath: String, usePageViewController: Bool = false) {
        if let fileHandle = FileHandle(forReadingAtPath: pdfPath) {
            let pdfData = fileHandle.readDataToEndOfFile()
            showPDF(pdfData: pdfData, usePageViewController: usePageViewController)
        }
    }
    
    /// Dataを指定して、PDFを表示する
    ///
    /// - Parameters:
    ///   - pdfData: PDFのデータ
    ///   - usePageViewController: trueの場合pageViewControllerを利用する
    private func showPDF(pdfData: Data, usePageViewController: Bool = false) {
        guard let pdfView = self.pdfView else {
            return
        }
        pdfView.usePageViewController(usePageViewController)
        pdfView.document = PDFDocument(data: pdfData)
    }
    
    /// URLを指定して、PDFを表示する
    ///
    /// - Parameters:
    ///   - pdfUrl: PDFのURL（ローカルのPDFのURL or Web上のPDFのURLを指定）
    ///   - usePageViewController: trueの場合pageViewControllerを利用する
    private func showPDF(pdfUrl: URL, usePageViewController: Bool = false) {
        guard let pdfView = self.pdfView else {
            return
        }
        pdfView.usePageViewController(usePageViewController)
        pdfView.document = PDFDocument(url: pdfUrl)
    }
}

// MARK: - PDF Configuration
extension PDFViewer {
    
    /// 任意の余白を設定する
    func pageBreakMargins(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        guard let pdfView = self.pdfView else {
            return
        }
        pdfView.displaysPageBreaks = true
        pdfView.pageBreakMargins = .init(top: top, left: left, bottom: bottom, right: right)
    }
    
    /// スクロールの方向を設定する
    ///
    /// - Parameter direction: PDFDisplayDirection
    func displayDirection(direction: PDFDisplayDirection) {
        guard let pdfView = self.pdfView else {
            return
        }
        pdfView.displayDirection = direction
    }
    
    /// 表示モードを設定する
    ///
    /// - Parameter mode: PDFDisplayMode
    func displayMode(mode: PDFDisplayMode = .singlePageContinuous) {
        guard let pdfView = self.pdfView else {
            return
        }
        pdfView.displayMode = mode
    }
    
    /// 見開きの時に最初のページを表紙として使用する
    ///
    /// 見開き（.twoUpContinuousまたは.twoUp）の場合のみ有効
    ///
    /// - Parameter asBook: true: 1ページ目を表紙とする, false: 表紙としない
    func displaysAsBook(_ asBook: Bool) {
        guard let pdfView = self.pdfView else {
            return
        }
        pdfView.displaysAsBook = asBook
    }
}
