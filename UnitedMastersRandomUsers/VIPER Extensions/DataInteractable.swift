import Foundation

enum DataResponse<T> {
    case success(data: T)
    case failure(error: Error)
}
