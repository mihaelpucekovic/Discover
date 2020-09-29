//
//  ResultEnum.swift
//  Discover
//
//  Created by Mihael Puceković on 25/09/2020.
//

enum ResultEnum<T> {
    case success(T)
    case failure(String)
}
