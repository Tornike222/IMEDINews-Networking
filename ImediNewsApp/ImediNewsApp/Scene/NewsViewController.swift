//
//  ViewController.swift
//  ImediNewsApp
//
//  Created by telkanishvili on 19.04.24.
//

import UIKit


class NewsViewController: UIViewController {
    
    //MARK: - UI Elements
    let newsTableView: UITableView = {
        let newsTableView = UITableView()
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.backgroundColor = .white
        return newsTableView
    }()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        getPostsData()
    }
    
    //MARK: - SetupUI
    func setupUI(){
        addTableView()
    }
    
    func addTableView(){
        view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
    }
}

//MARK: - DataSource extension and functions
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell
        cell?.postImage.image = nil
        let post = postList.list[indexPath.row]
        
        if let image = URL(string: post.photoUrl ?? ""){
            cell?.postImage.loadWithBlur(url: image)
        }
        
        cell?.dateLabel.text = post.time
        cell?.postLabel.text = post.title
        cell?.url = post.url
        return cell ?? UITableViewCell()
    }
    
    func getPostsData(){
        let urlString = "https://imedinews.ge/api/categorysidebarnews/get"
        let urlObject = URL(string: urlString)
        let urlRequest = URLRequest(url: urlObject!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("wrong response")
                return
            }
            
            let postsResponseData = try? JSONDecoder().decode(PostList.self, from: data!)
            let posts = postsResponseData?.list ?? []
            
            DispatchQueue.main.async {
                postList.list = posts
                self.newsTableView.reloadData()
            }
        }.resume()
    }
}

//MARK: - Delegate Extension and functions
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postList.list[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.modalPresentationStyle = .fullScreen
        detailsVC.post = post
        
        detailsVC.navigationItem.title = "Details"
        self.navigationController?.pushViewController(detailsVC, animated: false)
    }
    
    
}



