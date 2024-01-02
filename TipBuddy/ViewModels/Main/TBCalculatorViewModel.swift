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
        let updateViewPublisher = Publishers.CombineLatest3(input.billPublisher, input.tipPublisher, input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(bill: bill, tip: tip)
            let totalBill = bill + totalTip
            let amountPerPerson = totalBill / Double(split)
            let result = Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: totalTip)
            return Just(result)
        }.eraseToAnyPublisher()
        return Output(updateViewPublisher: updateViewPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.20
        case .customTip(let value):
            return Double(value)
        }
    }
}
