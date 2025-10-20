//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by zombiyamo on 2025/10/19.
//

import UIKit

extension ReminderListViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
  typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
  
  func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
    let reminder = Reminder.sampleData[indexPath.item]
    var contentConfiguration = cell.defaultContentConfiguration()
    contentConfiguration.text = reminder.title
    contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
    contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
    cell.contentConfiguration = contentConfiguration

    var backgroundConfiguration = UIBackgroundConfiguration.listCell()
    backgroundConfiguration.backgroundColor = .todayListCellBackground
    cell.backgroundConfiguration = backgroundConfiguration
  }
}
