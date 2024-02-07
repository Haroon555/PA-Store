//  Created by Faran Mushtaq on 25/02/2020.
//  Copyright © 2020 Appsnado. All rights reserved.

import Foundation

class ParsingManager<T: Decodable> {
    
    func parseModal(from response: Data) -> BaseModelObject<T>? {
        
        var parsedModal : BaseModelObject<T>!
        
        do {
            let decoder = JSONDecoder()
            let modal = try decoder.decode(BaseModelObject<T>.self, from: response)
            parsedModal = modal
            
        } catch let error {
            print(error)
        }
        
        return parsedModal
    }
    
    func parseArray(from response: Data) -> BaseModelArray<T>? {
        
        var parsedArray : BaseModelArray<T>!
        
        do {
            let decoder = JSONDecoder()
            let array = try decoder.decode(BaseModelArray<T>.self, from: response)
            parsedArray = array
            
        } catch let error {
            print(error)
        }
        
        return parsedArray
    }
    
}
