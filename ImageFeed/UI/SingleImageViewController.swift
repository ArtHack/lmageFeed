//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Artem on 26.03.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image else { return }
            singleImageView.image = image
            singleImageView.frame.size = image.size
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
        
    lazy var singleImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Backward")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.IFColors.black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let image else { return }
        singleImageView.image = image
        singleImageView.frame.size = image.size
        rescaleAndCenterImageInScrollView(image: image)
        
        view.addSubview(scrollView)
        scrollView.addSubview(singleImageView)
        scrollView.addSubview(backButton)
        
        setupConstraints()
        rescaleAndCenterImageInScrollView(image: image)
    }
// MARK: - Private Methods 
    @objc 
    private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func centerImageInScrollView() {
//        ToDo: isn't centered
        let imageViewSize = singleImageView.frame.size
        let scrollViewSize = view.frame.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalPadding,
            left: horizontalPadding,
            bottom: verticalPadding,
            right: horizontalPadding
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButton.heightAnchor.constraint(equalToConstant: 48),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            
            singleImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            singleImageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            singleImageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            singleImageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            
        ])
    }
}

// MARK: - UIScrollViewDelegate
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        singleImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageInScrollView()
    }
}
