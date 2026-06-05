//
//  AuthController.swift
//  AquaAlert
//
//  Created by Macbook on 05/06/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthController: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var isLoggedIn  = false
    @Published var isLoading   = false
    @Published var errorMessage: String?

    @Published var technicians: [UserModel] = []

    private let db = Firestore.firestore()

    init(shouldFetchCurrentUser: Bool = true) {
        if shouldFetchCurrentUser, let firebaseUser = Auth.auth().currentUser {
            fetchUserData(uid: firebaseUser.uid)
        }
    }

    func registerEmail(username: String, email: String, password: String, role: String, completion: ((Bool) -> Void)? = nil) {
        isLoading = true
        errorMessage = nil

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = self.friendlyError(error)
                    completion?(false)
                }
                return
            }
            guard let uid = result?.user.uid else { completion?(false); return }

            let userData: [String: Any] = ["id": uid, "name": username, "email": email, "role": role]
            self.db.collection("users").document(uid).setData(userData) { err in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let err = err {
                        self.errorMessage = err.localizedDescription
                        completion?(false)
                    } else {
                        self.currentUser = UserModel(id: uid, name: username, email: email, role: role)
                        self.isLoggedIn  = true
                        completion?(true)
                    }
                }
            }
        }
    }

    func createEmployeeAccount(
        username: String,
        email: String,
        password: String,
        role: String,
        completion: @escaping (Bool, String) -> Void
    ) {
        isLoading = true

        let currentFirebaseUser = Auth.auth().currentUser

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion(false, self.friendlyError(error))
                }
                return
            }
            guard let uid = result?.user.uid else {
                completion(false, "Gagal membuat akun.")
                return
            }

            let userData: [String: Any] = ["id": uid, "name": username, "email": email, "role": role]
            self.db.collection("users").document(uid).setData(userData) { err in
                try? Auth.auth().signOut()
                if let adminUser = currentFirebaseUser {
                    self.fetchUserData(uid: adminUser.uid)
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let err = err {
                        completion(false, err.localizedDescription)
                    } else {
                        completion(true, "Akun \(username) berhasil dibuat sebagai \(role).")
                    }
                }
            }
        }
    }

    func loginEmail(email: String, password: String) {
        isLoading = true
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = self.friendlyError(error)
                }
                return
            }
            guard let uid = result?.user.uid else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Gagal mendapatkan data akun."
                }
                return
            }
            self.fetchUserData(uid: uid)
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        DispatchQueue.main.async {
            self.currentUser = nil
            self.isLoggedIn  = false
        }
    }

    
