//
//  ViewController.swift
//  NewsApp
//
//  Created by Artem Hrynenko on 05.10.2022.
//


import UIKit
import SafariServices

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: K.cellReuseIdentifier)
        
        return table
    }()
    
    private var articles = [Article]()
    private var news = [NewsTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appTitle
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles ?? []
                self?.news = articles?.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title ?? "",
                        subtitle: $0.description ?? "",
                        imageUrl: URL(string: $0.urlToImage ?? ""))
                }) ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            case .failure(let failure):
                print(failure)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReuseIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
