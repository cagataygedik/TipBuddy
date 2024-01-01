//
//  TBCalculatorViewModel.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 30.12.2023.
//

import Foundation
import Combine

class TBCalculatorViewModel {
    
    struct Input {
        let billPublisher: AnyPublisher <Double, Never>
        let tipPublisher: AnyPublisher <Tip, Never>
        let splitPublisher: AnyPublisher <Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher <Result, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public func transform(input: Input) -> Output {
        input.splitPublisher.sink { split in
            print("split: \(split)")
        }.store(in: &cancellables)
        
        let result = Result(amountPerPerson: 500.0, totalBill: 1000, totalTip: 50.0)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
