//
//  ListViewController+Actions.swift
//  Today
//
//  Created by zombiyamo on 2025/10/22.
//

import UIKit

extension ReminderListViewController {
  @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
    guard let id = sender.id else { return }
    completeReminder(withId: id)
  }
}
