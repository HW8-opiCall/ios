//
//  UserService.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import Foundation
import Combine
import FirebaseAuth

final class SessionService {
    static func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    static func signInAnonymously() -> AnyPublisher<Result<Void, Error>, Never> {
        return Future<Result<Void, Error>, Never> {
            promise in
            Auth.auth().signInAnonymously {
                result, error in
                print(result?.user)
                if let error = error {
                    return promise(.success(.failure(error)))
                }
                
                if (result?.user) != nil {
                    return promise(.success(.success(())))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
