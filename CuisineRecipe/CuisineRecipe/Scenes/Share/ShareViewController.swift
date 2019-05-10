//
//  ShareViewController.swift
//  CuisineRecipe
//
//  Created by mac on 5/9/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class ShareViewController: UIViewController {
    @IBOutlet private weak var achievementImageView: UIImageView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    var achievementImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        hideKeyboardWhenTappedAround()
        guard let myImage = achievementImage else { return }
        achievementImageView.image = myImage
        
        descriptionTextView.then {
            $0.text = Constants.descriptionPlaceholder
            $0.textColor = UIColor.lightGray
            $0.delegate = self
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(handleCancelButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Colors.primaryColor
    }
    
    @objc
    func handleCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func handleShareButtonTapped(_ sender: Any) {
        guard let text = descriptionTextView.text,
            let image = achievementImageView.image else { return }
        
        let activityController = UIActivityViewController(activityItems: [text, image], applicationActivities: nil)
        activityController.completionWithItemsHandler = { [unowned self] (activity, success, items, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(activityController, animated: true, completion: nil)
    }
}

extension ShareViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.descriptionPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}

extension ShareViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
