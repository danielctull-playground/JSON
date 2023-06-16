
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct JSONMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CaseInitMacro.self,
    ]
}
