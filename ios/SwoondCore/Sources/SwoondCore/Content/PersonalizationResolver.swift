import Foundation

/// Resolves `{{team}}`-style tokens in authored text from a person's personalization values.
/// Supports `{{name|default text}}`: the value if present, else the inline default (trimmed).
/// Without a default, missing values fall back to `fallbacks`, then generic copy ("their team").
public struct PersonalizationResolver: Sendable {
    public var values: [String: String]
    public var fallbacks: [String: String]

    public init(values: [String: String], fallbacks: [String: String] = [:]) {
        self.values = values
        self.fallbacks = fallbacks
    }

    public init(interest: PersonInterest, fallbacks: [String: String] = [:]) { self.init(values: interest.personalization, fallbacks: fallbacks) }

    public func resolve(_ text: String) -> String {
        var out = ""
        var rest = Substring(text)
        while let open = rest.range(of: "{{") {
            out += rest[rest.startIndex..<open.lowerBound]
            let after = rest[open.upperBound...]
            guard let close = after.range(of: "}}") else { out += rest[open.lowerBound...]; return out }
            let body = after[after.startIndex..<close.lowerBound]
            var key = body.trimmingCharacters(in: .whitespaces)
            var inlineDefault: String?
            if let bar = body.firstIndex(of: "|") {
                key = body[body.startIndex..<bar].trimmingCharacters(in: .whitespaces)
                let d = body[body.index(after: bar)...].trimmingCharacters(in: .whitespaces)
                inlineDefault = d.isEmpty ? nil : d
            }
            out += values[key] ?? inlineDefault ?? fallbacks[key] ?? "their \(key)"
            rest = after[close.upperBound...]
        }
        out += rest
        return out
    }
}
