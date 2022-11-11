//
//  FileOfDocumenteModel.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 07.11.2022.
//

import Foundation

struct FileOfDocumenteModel {
    
    static let shared = FileOfDocumenteModel()
    
    func createDocument(_ nameDocument: String?) -> String {
        var pathDocument = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        if let nameDocument {
            pathDocument += "/" + nameDocument
        } else {
            pathDocument += "/"
        }
       
        do {
            try FileManager.default.createDirectory(atPath: pathDocument, withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
        return pathDocument
    }
    
    func savedImage(_ nameDocument: String?,  nameImage: String, imageSaved: URL) {
        var pathDocument = URL(filePath: createDocument(nil))
        
        if let nameDocument {
            pathDocument = URL(filePath: createDocument(nameDocument))
        }
        
        let namePath = pathDocument.appendingPathComponent(nameImage).path
        
        do {
            let data = try Data(contentsOf: imageSaved)
            
            if FileManager.default.fileExists(atPath: namePath) {
                do {
                   try  FileManager.default.removeItem(atPath: namePath)
                } catch {
                    print(error.localizedDescription)
                }
                
                FileManager.default.createFile(atPath: namePath, contents: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFile(_ pathDoc: String?, completion: ([String]) -> Void) {
        var pathImage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        if let pathDoc {
            pathImage = pathImage.appendingPathComponent(pathDoc)
        }
        var imagesReceived = [String]()
        
        do {
            imagesReceived = try FileManager.default.contentsOfDirectory(atPath: pathImage.path)
            
        } catch {
            print(error.localizedDescription)
            completion([])
        }
        completion(imagesReceived)
    }
    
    func removeFile(_ nameDocument: String?, nameFile: String) {
        let pathFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let filePath = pathFile.appendingPathComponent(nameFile)
        
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            print(error.localizedDescription)
        }
    }
}
