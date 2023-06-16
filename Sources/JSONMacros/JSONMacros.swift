
/// Add init for each case element with an associated type in the enum.
@attached(member, names: arbitrary)
public macro CaseInit() = #externalMacro(module: "JSONMacrosPlugin", type: "CaseInitMacro")
