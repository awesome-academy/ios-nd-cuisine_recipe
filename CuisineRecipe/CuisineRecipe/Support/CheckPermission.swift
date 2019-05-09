//
//  CheckPermission.swift
//  CuisineRecipe
//
//  Created by mac on 5/9/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Photos

enum PermissionMessage: String {
    case authorized = "Access is granted by user"
    case restricted = "User do not have access to photo album."
    case denied = "User has denied the permission."
}

func checkPermission(completion: @escaping (String) -> Void) -> Bool {
    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    switch photoAuthorizationStatus {
    case .authorized:
        return true
    case .notDetermined:
        PHPhotoLibrary.requestAuthorization({ (newStatus) in
            if newStatus == PHAuthorizationStatus.authorized {
                completion(PermissionMessage.authorized.rawValue)
                return
            }
        })
    case .restricted:
        completion(PermissionMessage.restricted.rawValue)
    case .denied:
        completion(PermissionMessage.denied.rawValue)
    }
    return false
}
