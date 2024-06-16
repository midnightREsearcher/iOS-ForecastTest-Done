//
//  ListViewModel.swift
//  App
//
//

import Global
import GlobalUI
import Combine

class ListViewModel {
    @Inject var service: ForecastService
    private var bag = Set<AnyCancellable>()
    
    var datas = CurrentValueSubject<[TableViewSection], Never>([])
    
    var showDetail: ((ForecastItem) -> Void)?
    
    var title: String = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
    
    init() {
        service.items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.createSection($0) }
            .store(in: &bag)
    }
    
    private func createSection(_ items: ForecastItems) {
        let datas: [TableViewData] = items.map {
            ListCellData(forecast: $0)
                .set(trailingActions: [self.trailingAction(item: $0)])
                .set(separator: .full)
                .set(separatorColor: .lightGray)
                .did(select: { [weak self] data in
                    guard let forecast = (data as? ListCellData)?.getForecast() else { return }
                    self?.showDetail?(forecast)
                })
        }
        self.datas.send([TableViewSection(identifier: "section", datas: datas)])
    }
    
    private func trailingAction(item: ForecastItem) -> TableViewContextualAction {
        return TableViewContextualAction(title: "Delete", style: .destructive, backgroundColor: .red) { [weak self] data in
            guard let self = self else { return }
            self.deleteItem(item)
        }
    }
    
    private func deleteItem(_ item: ForecastItem) {
        var currentItems = self.service.items.value
        currentItems.removeAll { $0.day == item.day && $0.description == item.description }
        self.service.items.send(currentItems)
    }
}
