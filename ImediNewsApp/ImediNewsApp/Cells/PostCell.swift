//
//  PostCell.swift
//  ImediNewsApp
//
//  Created by telkanishvili on 19.04.24.
//

import UIKit

class PostCell: UITableViewCell {
    // MARK: - Properties
    var url: String?
    
    //MARK: - UI Elements
    var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        return postImage
    }()
    
    let postLabelsStackView: UIStackView = {
        let postLabelsStackView = UIStackView()
        postLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        postLabelsStackView.axis = .vertical
        postLabelsStackView.alignment = .top
        return postLabelsStackView
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        dateLabel.font = UIFont(name: "FiraGO-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return dateLabel
    }()
    
    let postLabel: UILabel = {
        let postLabel = UILabel()
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postLabel.textAlignment = .center
        postLabel.textColor = .white
        postLabel.numberOfLines = 4
        postLabel.font = UIFont(name: "FiraGO-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13)
        return postLabel
    }()
    
    //MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        setSelectionStyle(selected: selected)
    }
    
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.height -= 16
            super.frame = frame
        }
    }
    
    // MARK: - UI Setup
    func setupUI(){
        addPostImage()
        addPostLabelsStackView()
        addDateAndDescription()
        addCorneredBorderRadius()
    }
    
    func setSelectionStyle(selected: Bool){
        selectionStyle = .none
    }
    
    func addCorneredBorderRadius(){
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func addPostLabelsStackView(){
        contentView.addSubview(postLabelsStackView)
        NSLayoutConstraint.activate([
            postLabelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            postLabelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            postLabelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postLabelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func addPostImage(){
        contentView.addSubview(postImage)
        NSLayoutConstraint.activate([
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func addDateAndDescription(){
        postLabelsStackView.alignment = .center
        postLabelsStackView.addArrangedSubview(dateLabel)
        postLabelsStackView.addArrangedSubview(postLabel)
    }
    
    
}

//MARK: - UIImageView Extension and functions
extension UIImageView {
    func loadWithBlur(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch image from URL: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to create image from data")
                return
            }
            
            let finalImage = self.blurImage(image: image) ?? image
            
            DispatchQueue.main.async {
                self.image = finalImage
                
            }
        }.resume()
    }
    
    func loadWithoutBlur(url: URL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }.resume()
    }
    
    func blurImage(image:UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: image)
        let originalOrientation = image.imageOrientation
        let originalScale = image.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage
        
        var cgImage:CGImage?
        
        if let output = outputImage{
            cgImage = context.createCGImage(output, from: (inputImage?.extent)!)
        }
        
        if let cgImageA = cgImage{
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
}

