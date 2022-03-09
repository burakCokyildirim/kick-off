//
//  HomeViewController.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 7.03.2022.
//
//  Template generated by Burak Cokyildirim
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Dependencies
    var presenter: HomePresenterViewProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchContents()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Configure
    override func configureView() {
        super.configureView()

        let logoutButtonItem = UIBarButtonItem(
            image: .init(systemName: "power"),
            style: .plain,
            target: self,
            action: #selector(logoutAction))
        navigationItem.setRightBarButton(logoutButtonItem, animated: true)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: ContentCell.className, bundle: .main),
            forCellReuseIdentifier: ContentCell.className)
    }

    // MARK: - Actions
    @objc func logoutAction() {
        presenter.logout()
    }
}

// MARK: - Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ContentCell.className, for: indexPath) as? ContentCell
        let content = presenter.content(of: indexPath.row)
        cell?.setup(with: content)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        let content = presenter.content(of: indexPath.row)
        DetailWireframe().show(
            transitionType: .push(navigationController: navigationController, animated: true),
            extras: content as Any)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Protocol Implemantations
extension HomeViewController: HomeViewControllerProtocol {
    func updateView() {
        tableView.reloadData()
    }
}