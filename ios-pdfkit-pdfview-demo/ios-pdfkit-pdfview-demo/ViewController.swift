//
//  ViewController.swift
//  ios-pdfkit-pdfview-demo
//
//  Created by OkuderaYuki on 2017/10/30.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var pdfBaseView: UIView!
    private var pdfViewer: PDFViewer?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PDFのURLを指定して、PDFを表示する
        if let url = URL(string: "https://www.apple.com/environment/pdf/Apple_Environmental_Responsibility_Report_2017.pdf") {
            pdfViewer = PDFViewer(frame: view.frame, pdfUrl: url)
        }
        
        // ファイル名を指定して、ローカルのPDFを表示する
//        pdfViewer = PDFViewer(frame: view.frame, localPDFName: "test")
        
        guard let pdfView = pdfViewer?.pdfView else {
            return
        }
        pdfBaseView.addSubview(pdfView)
        pdfViewer?.setupPdfView()
        pdfViewer?.show()
    }
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
        guard let pdfView = pdfViewer?.pdfView else {
            return
        }
        // 次のページに移動可能な場合、1ページ進む
        if pdfView.canGoToNextPage() {
            pdfView.goToNextPage(sender)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        
        guard let pdfView = pdfViewer?.pdfView else {
            return
        }
        // 前のページに移動可能な場合、1ページ戻る
        if pdfView.canGoToPreviousPage() {
            pdfView.goToPreviousPage(sender)
        }
    }
}
