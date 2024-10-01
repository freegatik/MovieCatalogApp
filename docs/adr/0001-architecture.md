# ADR 0001: layers

Accepted.

Presentation depends on domain protocols and entities. Data implements repositories and owns HTTP, Core Data, Keychain. Domain does not import UIKit or Alamofire. `AppError` / `AppLog` / URL defaults live in `Core` and `Data/Network`.
