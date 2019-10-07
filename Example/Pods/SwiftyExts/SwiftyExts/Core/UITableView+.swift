//
//  UITableView+.swift
//  SwiftyExts
//
//  Created by LDD on 2019/10/7.
//

#if os(iOS)
import UIKit

public extension UITableView {
    
    /// Number of all rows in all sections of tableView.
    ///
    /// - Returns: The count of all rows in the tableView.
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }

    var currentSection: Int {
        if let indexPath = self.indexPathsForVisibleRows?.first {
            return indexPath.section
        }
        return 0
    }

    var currentRow: Int {
        if let indexPath = self.indexPathsForVisibleRows?.first {
            return indexPath.row
        }
        return 0
    }
    
    /// Check whether IndexPath is valid within the tableView
    ///
    /// - Parameter indexPath: An IndexPath to check
    /// - Returns: Boolean value for valid or invalid IndexPath
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    /// Safely scroll to possibly invalid IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: Target IndexPath to scroll to
    ///   - scrollPosition: Scroll position
    ///   - animated: Whether to animate or not
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    /// IndexPath for last row in section.
    ///
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// 刷新数据
    ///
    /// - Parameter completion: 刷新完成回调
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    func reloadSectionsWithoutAnimation(indexSet: IndexSet) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.performWithoutAnimation { [weak self] in
                guard let self = self else { return }
                self.reloadSections(indexSet, with: .none)
            }
        }
    }

    func reloadRowsWithoutAnimation(indexPathArray: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.performWithoutAnimation { [weak self] in
                guard let self = self else { return }
                self.reloadRows(at: indexPathArray, with: .none)
            }
        }
    }
}

// MARK: - Methods
public extension UITableView {
    
    /// Remove TableFooterView.
    func removeTableFooterView() {
        tableFooterView = nil
    }
    
    /// Remove TableHeaderView.
    func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    /// 获取 UITableViewCell
    ///
    /// - Parameter name: 继承UITableViewCell类Class
    /// - Returns: Cell
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    
    /// 获取 UITableViewCell
    ///
    /// - Parameters:
    ///   - name: 继承UITableViewCell类Class
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    
    /// 获取 UITableViewSection头部和尾部
    ///
    /// - Parameter name: 继承UITableViewHeaderFooterView类Class
    /// - Returns: UITableViewSection头部和尾部
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }
    
    /// 获取 Nib UITableViewSection头部和尾部
    ///
    /// - Parameters:
    ///   - nib: nib
    ///   - name: UITableViewSection头部和尾部
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// 注册 UITableViewSection头部和尾部
    ///
    /// - Parameter name: UITableViewSection头部和尾部
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// 注册 UITableViewCell
    ///
    /// - Parameter name: Cell
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    /// 注册 Nib UITableViewCell
    ///
    /// - Parameters:
    ///   - nib: nib
    ///   - name: Cell
    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
    
    /// 注册 Nib UITableViewCell
    ///
    /// - Parameters:
    ///   - name: 继承UITableViewCell类Class
    ///   - bundleClass: bundleClass
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    
    
}

#endif

