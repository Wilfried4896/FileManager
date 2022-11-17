//
//  OnboardingController.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.11.2022.
//

import UIKit

class OnboardingController: UIViewController {
    
    weak var coordinator: OnboardingCoordinator?

    var imageData = ImageData.shared
    
    var imageReceved = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var cameraButton: UIBarButtonItem = {
        let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(didTapCamera))
        return camera
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 20
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingConfiguration()
    }

    private func onboardingConfiguration() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = cameraButton
        
        navigationItem.title = "Документы"
        navigationController?.navigationBar.prefersLargeTitles = true
                
        view.addSubview(tableView)
           
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageData.loadImage { imageSaved in
            imageReceved = imageSaved
            
        }
    }
   
    @objc func didTapCamera() {
        chooseCameraOrGallery()
    }
    
    private func imagePixel(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePixel = UIImagePickerController()
        imagePixel.sourceType = sourceType
        return imagePixel
    }
    
    private func chooseCameraOrGallery() {
        let messageAlert = UIAlertController(title: "Add new image", message: "Choose", preferredStyle: .actionSheet)
        messageAlert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            let gallery = self.imagePixel(sourceType: .photoLibrary)
            gallery.delegate = self
            self.present(gallery, animated: true)
        }))
        
        messageAlert.addAction(UIAlertAction(title: "Камера (Только с реальным устройством)", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            let camera = self.imagePixel(sourceType: .camera)
            camera.delegate = self
            self.present(camera, animated: true)
        }))
        
        messageAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(messageAlert, animated: true)
    }
}

extension OnboardingController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageReceved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = imageReceved[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            imageData.removeImage(image: imageReceved [indexPath.row])
            imageReceved.remove(at: indexPath.row)
        }
    }
}

extension OnboardingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageUrl = info[.imageURL] as! URL
        imageData.savedImageFile(imageUrl: imageUrl)
        
        imageData.loadImage { image in
            imageReceved = image
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             picker.dismiss(animated: true)
        }
    }
}


