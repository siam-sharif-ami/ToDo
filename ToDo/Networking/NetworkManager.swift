//
//  NetworkManager.swift
//  ToDo
//
//  Created by BS00484 on 30/6/24.
//

import Foundation
import Firebase
import FirebaseStorage

class NetworkManager{
    func pushToFirebaseStorage(imageData: Data) async throws -> String {
        let storageRef = Storage.storage().reference()
        let imagesRef = storageRef.child("images")
        
        let imageName = UUID().uuidString + ".jpg"
        let imageRef = imagesRef.child(imageName)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata){metadata, error in
            if let error = error {
                print("failure uploading data \(error.localizedDescription)")
            }
        }
        
        let url = try await imageRef.downloadURL()
        print(url)
        return url.absoluteString
    }
}
