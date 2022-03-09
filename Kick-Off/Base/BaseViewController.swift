//
//  BaseViewController.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//
//  Template generated by Burak Cokyildirim
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    lazy var loadingView: NVActivityIndicatorView? = makeLoadingView()
    lazy var blockerView: UIView? = makeBlockerView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Configure
    func configureView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard(press:)))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    // MARK: - Initialization
    private func makeLoadingView() -> NVActivityIndicatorView? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        let loading = NVActivityIndicatorView(
            frame: CGRect.zero, type: .ballPulseSync, color: .systemBlue, padding: 20)
        window.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        return loading
    }

    private func makeBlockerView() -> UIView? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        let blocker = UIView(frame: window.frame)
        blocker.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return blocker
    }

    @objc func dismissKeyboard(press: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
}

// MARK: - Protocol Implemantations
extension BaseViewController: BaseViewControllerProtocol {
    func showAlert(with errorMessage: String) {
        let alert = UIAlertController(
            title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func showLoading() {
        guard let window = UIApplication.shared.windows.first else { return }

        if let blockerView = blockerView {
            window.addSubview(blockerView)
        }

        loadingView?.startAnimating()

        if let loadingView = loadingView {
            window.bringSubviewToFront(loadingView)
        }

        self.view.isUserInteractionEnabled = false
    }

    func hideLoading() {
        blockerView?.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        loadingView?.stopAnimating()
    }
}
