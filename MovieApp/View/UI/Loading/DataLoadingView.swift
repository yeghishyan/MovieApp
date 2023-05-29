//
//  DataFetchPhaseOverlayView.swift
//

import SwiftUI

protocol EmptyData {
    var isEmpty: Bool { get }
}

struct DataLoadingView<T: EmptyData>: View {
    let phase: DataFetchPhase<T>
    let retryAction: () -> ()
    
    var body: some View {
        switch phase {
        case .empty:
            LoadingFiveLinesChronological()
        case .success(let value) where value.isEmpty:
            EmptyPlaceholderView(text: "No data", image: Image(systemName: "light.ribbon"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: retryAction)
        default:
            EmptyView()
        }
    }
}

struct EmptyPlaceholderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct RetryView: View {
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("Try Again")
            }
        }
    }
}

extension Array: EmptyData {}
extension Optional: EmptyData {
    var isEmpty: Bool {
        if case .none = self {
            return true
        }
        return false
    }
}

#if DEBUG
struct DataFetchPhaseOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DataLoadingView<[Any]>(phase: .success([])) {
                print("Retry")
            }
            DataLoadingView<[Movie]>(phase: .empty) {
                print("Retry")
            }
            DataLoadingView<Movie?>(phase: .failure(MovieAPIError.invalidResponse)) {
                print("Retry")
            }
        }
    }
}
#endif
