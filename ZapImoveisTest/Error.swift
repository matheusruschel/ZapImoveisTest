//
//  Error.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

enum ErrorCode: ErrorType {
    case CanceledTask, JSONNotRecognizedError
}

enum Error : ErrorType {
    case ErrorWithCode(errorCode:ErrorCode)
    case ErrorWithMsg(msg: String)
}