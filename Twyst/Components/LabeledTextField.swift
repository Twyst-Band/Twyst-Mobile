import SwiftUI

struct LabeledTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var password: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.DIN())
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.5))
            CustomTextField(
                placeholder: placeholder,
                text: $text,
                password: password
            )
        }
    }
}

#Preview {
    @Previewable @State var value: String = ""

    LabeledTextField(
        label: "Password",
        placeholder: "Enter password",
        text: $value,
        password: true
    ).padding(.horizontal)
}
