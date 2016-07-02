//
//          File:   TUIBorders.swift
//    Created by:   African Swift

import Darwin

// MARK: -
// MARK: TUIBorders -

/// TUI collection of borders to construct view edges, tables, ...
public indirect enum TUIBorders
{
  /// __Standard Borders__
  ///
  /// ````
  /// ┌──┬──┐  ╔══╦══╗  ╒══╤══╕  ╓──╥──╖
  /// │  │  │  ║  ║  ║  │  │  │  ║  ║  ║
  /// ├──┼──┤  ╠══╬══╣  ╞══╪══╡  ╟──╫──╢
  /// │  │  │  ║  ║  ║  │  │  │  ║  ║  ║
  /// └──┴──┘  ╚══╩══╝  ╘══╧══╛  ╙──╨──╜
  /// single   double   double2  double3
  /// ````
  case single, double, double2, double3
  
  /// __Block Borders__
  ///
  /// ````
  /// ███████   ▓▓▓▓▓▓▓   ░░░░░░░   ▛▀▀▀▀▀▜
  /// █  │  █   ▓  │  ▓   ░  │  ░   ▌  │  ▐
  /// █──┼──█   ▓──┼──▓   ░──┼──░   ▌──┼──▐
  /// █  │  █   ▓  │  ▓   ░  │  ░   ▌  │  ▐
  /// ███████   ▓▓▓▓▓▓▓   ░░░░░░░   ▙▃▃▃▃▃▟
  /// block100  block75   block50   halfblock
  /// ````
  case block100, block75, block50, halfblock
  
  /// __ASCII Borders__
  ///
  /// ````
  /// +--+--+    -------    /-----\
  /// |  |  |    |  |  |    |  |  |
  /// |--+--|    |--+--|    |--+--|
  /// |  |  |    |  |  |    |  |  |
  /// +--+--+    -------    \-----/
  /// ascii      ascii2     ascii3
  /// ````
  case ascii, ascii2, ascii3
  
  /// __Other Borders__
  ///
  /// **Custom:** example:
  ///
  /// ````
  /// let attr = Ansi.Color.Foreground.yellow()
  ///
  /// let custom = TUIBox(
  ///   top: TUIBoxLine(left: "┌", middle: "┬", right: "┐", attribute: attr),
  ///   middle: TUIBoxLine(left: "├", middle: "┼", right: "┤", attribute: attr),
  ///   bottom: TUIBoxLine(left: "└", middle: "┴", right: "┘", attribute: attr),
  ///   horizontal: TUIBoxHorizontal(top: "─", middle: "─", bottom: "─", attribute: attr),
  ///   vertical: TUIBoxLine(left: "│", middle: "│", right: "│", attribute: attr))
  /// ````
  ///
  /// **None:** example: 
  /// - borderless view
  case custom(border: TUIBorders, attribute: Ansi), none
  
  /// Array of all TUIBorders
  ///
  /// - returns: [.single, .double, .double2, .double3,
  /// .block100, .block75, .block50, .halfblock,
  /// .ascii, ascii2, ascii3, .none ]
  internal static var allCases: [TUIBorders] =
    [.single, .double, .double2, .double3,
    .block100, .block75, .block50, .halfblock,
    .ascii, ascii2, ascii3, .none ]
  
  /// Standard TUIBox(es) : single, double, double2 and double3
  ///
  /// - parameters:
  ///   - attribute: Ansi (custom Ansi attributes and/or color)
  /// - returns: TUIBox?
  private func matchStandardBoxes(attribute attr: Ansi) -> TUIBox?
  {
    switch self
    {
      case single:
        return TUIBox(
          top: TUIBoxLine(left: "┌", middle: "┬", right: "┐", attribute: attr),
          middle: TUIBoxLine(left: "├", middle: "┼", right: "┤", attribute: attr),
          bottom: TUIBoxLine(left: "└", middle: "┴", right: "┘", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "─", middle: "─", bottom: "─", attribute: attr),
          vertical: TUIBoxLine(left: "│", middle: "│", right: "│", attribute: attr))
      case double:
        return TUIBox(
          top: TUIBoxLine(left: "╔", middle: "╦", right: "╗", attribute: attr),
          middle: TUIBoxLine(left: "╠", middle: "╬", right: "╣", attribute: attr),
          bottom: TUIBoxLine(left: "╚", middle: "╩", right: "╝", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "═", middle: "═", bottom: "═", attribute: attr),
          vertical: TUIBoxLine(left: "║", middle: "║", right: "║", attribute: attr))
      case double2:
        return TUIBox(
          top: TUIBoxLine(left: "╒", middle: "╤", right: "╕", attribute: attr),
          middle: TUIBoxLine(left: "╞", middle: "╪", right: "╡", attribute: attr),
          bottom: TUIBoxLine(left: "╘", middle: "╧", right: "╛", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "═", middle: "═", bottom: "═", attribute: attr),
          vertical: TUIBoxLine(left: "│", middle: "│", right: "│", attribute: attr))
      case double3:
        return TUIBox(
          top: TUIBoxLine(left: "╓", middle: "╥", right: "╖", attribute: attr),
          middle: TUIBoxLine(left: "╟", middle: "╫", right: "╢", attribute: attr),
          bottom: TUIBoxLine(left: "╙", middle: "╨", right: "╜", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "─", middle: "─", bottom: "─", attribute: attr),
          vertical: TUIBoxLine(left: "║", middle: "║", right: "║", attribute: attr))
      default:
        // if not matched, search blocks
        return matchBlockBoxes(attribute: attr)
    }
  }
  
  /// Block TUIBox(es) : halfBlock, block100, block75 and block50
  ///
  /// - parameters:
  ///   - attribute: Ansi (custom Ansi attributes and/or color)
  /// - returns: TUIBox?
  private func matchBlockBoxes(attribute attr: Ansi) -> TUIBox?
  {
    switch self
    {
      case block100:
        return TUIBox(
          top: TUIBoxLine(left: "█", middle: "█", right: "█", attribute: attr),
          middle: TUIBoxLine(left: "█", middle: "┼", right: "█", attribute: attr),
          bottom: TUIBoxLine(left: "█", middle: "█", right: "█", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "█", middle: "─", bottom: "█", attribute: attr),
          vertical: TUIBoxLine(left: "█", middle: "│", right: "█", attribute: attr))
      case block75:
        return TUIBox(
          top: TUIBoxLine(left: "▓", middle: "▓", right: "▓", attribute: attr),
          middle: TUIBoxLine(left: "▓", middle: "┼", right: "▓", attribute: attr),
          bottom: TUIBoxLine(left: "▓", middle: "▓", right: "▓", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "▓", middle: "─", bottom: "▓", attribute: attr),
          vertical: TUIBoxLine(left: "▓", middle: "│", right: "▓", attribute: attr))
      case block50:
        return TUIBox(
          top: TUIBoxLine(left: "░", middle: "░", right: "░", attribute: attr),
          middle: TUIBoxLine(left: "░", middle: "┼", right: "░", attribute: attr),
          bottom: TUIBoxLine(left: "░", middle: "░", right: "░", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "░", middle: "─", bottom: "░", attribute: attr),
          vertical: TUIBoxLine(left: "░", middle: "│", right: "░", attribute: attr))
      case halfblock:
        return TUIBox(
          top: TUIBoxLine(left: "▛", middle: "▀", right: "▜", attribute: attr),
          middle: TUIBoxLine(left: "▌", middle: "┼", right: "▐", attribute: attr),
          bottom: TUIBoxLine(left: "▙", middle: "▃", right: "▟", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "▀", middle: "─", bottom: "▃", attribute: attr),
          vertical: TUIBoxLine(left: "▌", middle: "│", right: "▐", attribute: attr))
      default:
        // if not matched, search other
        return matchOtherBoxes(attribute: attr)
    }
  }

  /// Other TUIBox(es) : ascii, custom and none
  ///
  /// - parameters:
  ///   - attribute: Ansi (custom Ansi attributes and/or color)
  /// - returns: TUIBox?
  private func matchOtherBoxes(attribute attr: Ansi) -> TUIBox?
  {
    switch self
    {
      case ascii:
        return TUIBox(
          top: TUIBoxLine(left: "+", middle: "+", right: "+", attribute: attr),
          middle: TUIBoxLine(left: "+", middle: "+", right: "+", attribute: attr),
          bottom: TUIBoxLine(left: "+", middle: "+", right: "+", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "-", middle: "-", bottom: "-", attribute: attr),
          vertical: TUIBoxLine(left: "|", middle: "|", right: "|", attribute: attr))
      case ascii2:
        return TUIBox(
          top: TUIBoxLine(left: "-", middle: "-", right: "-", attribute: attr),
          middle: TUIBoxLine(left: "|", middle: "+", right: "|", attribute: attr),
          bottom: TUIBoxLine(left: "-", middle: "-", right: "-", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "-", middle: "-", bottom: "-", attribute: attr),
          vertical: TUIBoxLine(left: "|", middle: "|", right: "|", attribute: attr))
      case ascii3:
        return TUIBox(
          top: TUIBoxLine(left: "\u{2F}", middle: "-", right: "\u{5C}", attribute: attr),
          middle: TUIBoxLine(left: "|", middle: "+", right: "|", attribute: attr),
          bottom: TUIBoxLine(left: "\u{5C}", middle: "-", right: "\u{2F}", attribute: attr),
          horizontal: TUIBoxHorizontal(top: "-", middle: "-", bottom: "-", attribute: attr),
          vertical: TUIBoxLine(left: "|", middle: "|", right: "|", attribute: attr))
      case custom(let customBorder, let customAttr):
        return customBorder.toTUIBox(attribute: customAttr)
      case none:
        return nil
      default:
        return nil
    }
  }
  
  /// Output to TUIBox
  ///
  /// - parameters:
  ///   - attribute: Ansi (custom Ansi attributes and/or color)
  /// - returns: TUIBox?
  internal func toTUIBox(
    attribute attr: Ansi = Ansi.Color.Foreground.lightGray()) -> TUIBox?
  {
    return matchStandardBoxes(attribute: attr)
  }
}

// MARK: -
// MARK: TUIBoxLine -
internal struct TUIBoxLine
{
  internal let left: Ansi
  internal let middle: Ansi
  internal let right: Ansi
  
  /// Default initializer
  ///
  /// - parameters:
  ///   - left: Ansi
  ///   - middle: Ansi
  ///   - right: Ansi
  ///   - attribute: Ansi
  internal init(
    left: Character,
    middle: Character,
    right: Character,
    attribute: Ansi = "")
  {
    let reset = attribute != "" ? Ansi.Attribute.reset() : ""
    self.left = attribute + left + reset
    self.middle = attribute + middle + reset
    self.right = attribute + right + reset
  }
}

// MARK: -
// MARK: TUIBoxHorizontal -
internal struct TUIBoxHorizontal
{
  internal let top: Ansi
  internal let middle: Ansi
  internal let bottom: Ansi
  
  /// Default initializer
  ///
  /// - parameters:
  ///   - top: Ansi
  ///   - middle: Ansi
  ///   - bottom: Ansi
  ///   - attribute: Ansi
  internal init(
    top: Character,
    middle: Character,
    bottom: Character,
    attribute: Ansi = "")
  {
    let reset = attribute != "" ? Ansi.Attribute.reset() : ""
    self.top = attribute + top + reset
    self.middle = attribute + middle + reset
    self.bottom = attribute + bottom + reset
  }
}

// MARK: -
// MARK: TUIBox -
internal struct TUIBox
{
  internal let top: TUIBoxLine
  internal let middle: TUIBoxLine
  internal let bottom: TUIBoxLine
  internal let horizontal: TUIBoxHorizontal
  internal let vertical: TUIBoxLine
  
  /// Default initializer
  ///
  /// - parameters:
  ///   - top: TUIBoxLine
  ///   - middle: TUIBoxLine
  ///   - bottom: TUIBoxLine
  ///   - horizontal: TUIBoxHorizontal
  ///   - vertical: TUIBoxLine
  internal init(
    top: TUIBoxLine,
    middle: TUIBoxLine,
    bottom: TUIBoxLine,
    horizontal: TUIBoxHorizontal,
    vertical: TUIBoxLine)
  {
    self.top = top
    self.middle = middle
    self.bottom = bottom
    self.horizontal = horizontal
    self.vertical = vertical
  }
}