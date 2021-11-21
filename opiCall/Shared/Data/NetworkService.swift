//
//  NetworkService.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import Foundation

enum NetworkError: Error {
    case NotFound
    case decodeError
    case convertError(to: String)
    case error(description: String)
    case unknown
}

//final class NetworkService: ObservableObject {
//    public static func updateProfile(profile: UserModel, completion: @escaping (Result<Void, NetworkError>) -> Void) {
//        guard let dict = try? profile.asDictionary() else {
//            completion(.failure(.convertError(to: "dict")))
//            return
//        }
//        
//        FirestoreDB.userDoc(profile.uid!).setData(dict) {
//            (error) in
//            
//            if error != nil {
//                completion(.failure(.error(description: error!.localizedDescription)))
//            }
//            
//            completion(.success(()))
//        }
//    }
//    
//    public static func getProfile(userId: String, completion: @escaping (Result<StudentUserModel, NetworkError>) -> Void) {
//        FirestoreDB.userDoc(userId).getDocument {
//            (document, error) in
//            
//            if let dict = document?.data() {
//                guard let decodedUser = try? StudentUserModel.init(fromDictionary: dict) else {
//                    completion(.failure(.decodeError))
//                    return
//                }
//                
//                completion(.success(decodedUser))
//            } else {
//                completion(.failure(.NotFound))
//            }
//        }
//    }
//}
