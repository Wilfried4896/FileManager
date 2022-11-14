//
//  Onboarding.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 07.11.2022.
//

import UIKit

class OnboardingVC: UIViewController, Storyboarded {
    weak var coordinator: OnboardingCoordinator?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private lazy var addDocument: UIBarButtonItem = {
        let document = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(didTapAddDocument))
        return document
    }()
    
    private lazy var addFile: UIBarButtonItem = {
        let file = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddFile))
        return file
    }()
    
    let fileOfDocumenteModel = FileOfDocumenteModel.shared
    var fileCreated = String()
    var dataFromDocument = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems =  [addFile, addDocument]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fileOfDocumenteModel.loadFile(nil) { fileData  in
            dataFromDocument = fileData
        }
    }
    
    @objc func didTapAddDocument() {
          nameFileCreate()
    }
    
     @objc func didTapAddFile() {
         coordinator?.start()
    }
    
    private func nameFileCreate() {
        let arletMessage = UIAlertController(title: "Create new file", message: nil, preferredStyle: .alert)
        
        arletMessage.addTextField{ textField in
            textField.placeholder = "Enter name of the File"
        }
 
        arletMessage.addAction(UIAlertAction(title: "Saved", style: .default, handler: { [weak self] _ in

            guard let self, let textFields = arletMessage.textFields?[0].text else { return }
            self.fileOfDocumenteModel.loadFile(self.fileOfDocumenteModel.createDocument(textFields)) { fileData in
                self.dataFromDocument = fileData
            }
        }))

        arletMessage.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))

        self.present(arletMessage, animated: true)
    }
}

extension OnboardingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFromDocument.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
        
        cell.nameFile.text = dataFromDocument[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleted = UITableViewRowAction(style: .destructive, title: "Удалить") { _, indexPath in
            self.fileOfDocumenteModel.removeFile(nil, nameFile: self.dataFromDocument[indexPath.row])
            self.dataFromDocument.remove(at: indexPath.row)

        }
        return [deleted]
    }
    
}
