//
//  ErrorNetwork.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import Foundation

extension Network {
    struct ErrorCode {
        var message:String?
        var title:String?
        
        init(_ code: Int) {
            switch code {
            case 100:
                title = "Ошибка в подготовке"
                message = "Ошибка при подготовке JSON данных на отправку. Код ошибки \(code)"
            case 200...299:
                title = "Нет ошибки"
                message = "Ошибки нет или его не получилось определить. Код: \(code)"
            case 99:
                title = "Отсутсвует интерент"
                message =  "Отсутсвует интернет соединение или оно слишком слабое. \nКод ошибки: \(code)"
            case 101:
                title = "Ошибка"
                message = "Ошибка в стуктурировании полученных данных. \nError cod: \(code)"
            case 403:
                title = "Ошибка идентификации"
                message = "Требуется авторизация или обновление токена идентификации. Код ошибки \(code)"
            case 500...:
                title = "Ошибка сервера"
                message = "Возможно сервер временно не доступен. Код ошибки \(code)"
            default:
                title = "Ошибка"
                message = "Что-то пошло не так. Код ошибки: \(code)"
            }
        }
        
        init() {
            title = "Нет ошибки"
            message = "Ошибки нет или его не получилось определить, возможно плохой программист. Код ошибки \(200)"
        }
    }
}
