
import SwiftSyntax
import SwiftSyntaxMacros

public struct CaseInitMacro: MemberMacro {

    public static func expansion<
        Declaration: DeclGroupSyntax, Context: MacroExpansionContext
    >(
        of node: AttributeSyntax,
        providingMembersOf declaration: Declaration,
        in context: Context
    ) throws -> [DeclSyntax] {

        let modifier = declaration.modifiers?.description ?? ""

        return declaration.memberBlock.members.compactMap { member in

            guard
                let caseDecl = member.decl.as(EnumCaseDeclSyntax.self),
                let element = caseDecl.elements.first,
                let associatedValue = element.associatedValue,
                associatedValue.parameterList.count == 1,
                let parameter = associatedValue.parameterList.first
            else {
                return nil
            }

            let type = parameter.type.description
            let name = element.identifier

            return """
            \(raw: modifier)init(_ \(raw: name): \(raw: type)) {
                self = .\(raw: name)(\(raw: name))
            }
            """
        }
    }
}
