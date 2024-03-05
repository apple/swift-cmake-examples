import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let arg = node.arguments.first,
            node.arguments.count == 1 else {
            throw CustomError("stringify requires exactly one argument")
        }
        return "(\(arg), \(literal: arg.description))"
    }
}

@main
struct MacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
    ]
}

struct CustomError: Error, CustomStringConvertible {
    var msg: String
    init(_ msg: String) { self.msg = msg }
    var description: String { self.msg }
}
