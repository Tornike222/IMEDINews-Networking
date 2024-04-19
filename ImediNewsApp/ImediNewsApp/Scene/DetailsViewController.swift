//
//  DetailsViewController.swift
//  ImediNewsApp
//
//  Created by telkanishvili on 20.04.24.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Properties
    var post: PostModel?
    
    //MARK: - UI Elements
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-Bold", size: 17)
        label.textAlignment = .right
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "FiraGO-Regular", size: 20)
        textView.isEditable = false
        textView.isScrollEnabled = true 
        return textView
    }()
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindData()
        view.backgroundColor = .white
    }
    
    // MARK: - UI Setup
    func setupUI() {
        addPostImageView()
        addDateLabel()
        addTitleTextView()
    }
    
    func addPostImageView(){
        view.addSubview(postImageView)
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            postImageView.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    func addDateLabel(){
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 13),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    func addTitleTextView() {
        view.addSubview(titleTextView)
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 26),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            titleTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)

        ])
    }
    
    // MARK: - Data Binding
    func bindData() {
        guard let post = post else { return }
        
        if let imageUrl = URL(string: post.photoUrl!) {
            postImageView.loadWithoutBlur(url: imageUrl)

        }
        
        dateLabel.text = post.time
        titleTextView.text = post.title
    }
}
