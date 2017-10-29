//
//  ViewController.swift
//  ios-pdfkit-pdfview-demo
//
//  Created by OkuderaYuki on 2017/10/30.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {
    
    // MARK: - View Life Cycle
    
    // PDFView property
    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPdfView()
        // ファイル名を指定して、ローカルのPDFを表示する
        let pdfName = "test"
        showPDF(pdfName: pdfName)
    }
    
    // Actions
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
        // 次のページに移動可能な場合、1ページ進む
        if pdfView.canGoToNextPage() {
            pdfView.goToNextPage(sender)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        
        // 前のページに移動可能な場合、1ページ戻る
        if pdfView.canGoToPreviousPage() {
            pdfView.goToPreviousPage(sender)
        }
    }
    
    // MARK: - PDF表示
    
    /// Dataを指定して、PDFを表示する
    ///
    /// - Parameters:
    ///   - pdfData: PDFのデータ
    ///   - usePageViewController: trueの場合pageViewControllerを利用する
    func showPDF(pdfData: Data, usePageViewController: Bool = false) {
        pdfView.usePageViewController(usePageViewController)
        pdfView.document = PDFDocument(data: pdfData)
    }
    
    /// URLを指定して、PDFを表示する
    ///
    /// - Parameters:
    ///   - pdfUrl: PDFのURL（ローカルのPDFのURL or Web上のPDFのURLを指定）
    ///   - usePageViewController: trueの場合pageViewControllerを利用する
    func showPDF(pdfUrl: URL, usePageViewController: Bool = false) {
        pdfView.usePageViewController(usePageViewController)
        pdfView.document = PDFDocument(url: pdfUrl)
    }
    
    /// PATHを指定して、PDFを表示する
    ///
    /// - Parameters:
    ///   - pdfPath: PDFファイルのPATH
    ///   - usePageViewController: trueの場合pageViewControllerを利用する
    func showPDF(pdfPath: String, usePageViewController: Bool = false) {
        if let fileHandle = FileHandle(forReadingAtPath: pdfPath) {
            let pdfData = fileHandle.readDataToEndOfFile()
            showPDF(pdfData: pdfData,
                    usePageViewController: usePageViewController)
        }
    }
    
    /// ローカルのPDFのファイル名を指定して、画面に表示する
    ///
    /// - Parameter pdfName: foo.pdfの場合 -> foo
    func showPDF(pdfName: String, usePageViewController: Bool = false) {
        if let pdfPath = Bundle.main.path(forResource: pdfName, ofType: "pdf") {
            showPDF(pdfPath: pdfPath,
                    usePageViewController: usePageViewController)
        }
    }
    
    // MARK: - PDF Configuration
    
    /// PDFViewの初期処理をする
    func setupPdfView() {
        
        // 初期表示が画面サイズにピッタリ収まるようにする
        pdfView.autoScales = true
        
        // 余白を消す
        // pdfView.displaysPageBreaks = false
        
        // 余白を設定する
        // pageBreakMargins(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        // 背景色を設定
        pdfView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.8, alpha: 1)
        
        // スクロール方向に横向きを設定
        // pdfView.autoScalesがtrueで、スクロール方向を横向きにすると、小さく表示されてしまう
        // displayDirection(direction: .vertical)
        
        displayMode(mode: .singlePageContinuous)
        // displaysAsBook(true)
    }
    
    /// 任意の余白を設定する
    func pageBreakMargins(top: CGFloat,
                          left: CGFloat,
                          bottom: CGFloat,
                          right: CGFloat) {
        pdfView.displaysPageBreaks = true
        pdfView.pageBreakMargins = UIEdgeInsetsMake(top, left, bottom, right)
    }
    
    /// スクロールの方向を設定する
    ///
    /// - Parameter direction: PDFDisplayDirection
    func displayDirection(direction: PDFDisplayDirection) {
        pdfView.displayDirection = direction
    }
    
    /// 表示モードを設定する
    ///
    /// - Parameter mode: PDFDisplayMode
    func displayMode(mode: PDFDisplayMode = .singlePageContinuous) {
        pdfView.displayMode = mode
    }
    
    /// 見開きの時に最初のページを表紙として使用する
    ///
    /// 見開き（.twoUpContinuousまたは.twoUp）の場合のみ有効
    ///
    /// - Parameter asBook: true: 1ページ目を表紙とする, false: 表紙としない
    func displaysAsBook(_ asBook: Bool) {
        pdfView.displaysAsBook = asBook
    }
}

