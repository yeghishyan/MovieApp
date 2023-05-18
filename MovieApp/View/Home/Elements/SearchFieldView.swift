////
////  SearchFieldView.swift
////
//
//import SwiftUI
//import Combine
//
//open class SearchTextObservable: ObservableObject {
//    @Published public var searchText = "" {
//        willSet {
//            DispatchQueue.main.async {
//                self.searchSubject.send(newValue)
//            }
//        }
//        didSet {
//            DispatchQueue.main.async {
//                self.onUpdateText(text: self.searchText)
//            }
//        }
//    }
//        
//    public let searchSubject = PassthroughSubject<String, Never>()
//    
//    private var searchCancellable: Cancellable? {
//        didSet {
//            oldValue?.cancel()
//        }
//    }
//    
//    deinit {
//        searchCancellable?.cancel()
//    }
//    
//    public init() {
//        searchCancellable = searchSubject.eraseToAnyPublisher()
//            .map {
//                $0
//        }
//        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
//        .removeDuplicates()
//        .filter { !$0.isEmpty }
//        .sink(receiveValue: { (searchText) in
//            self.onUpdateTextDebounced(text: searchText)
//        })
//    }
//    
//    open func onUpdateText(text: String) {
//        /// Overwrite by your subclass to get instant text update.
//    }
//    
//    open func onUpdateTextDebounced(text: String) {
//        /// Overwrite by your subclass to get debounced text update.
//    }
//}
//
//struct SearchField : View {
//    @Binding var isSearching: Bool
//    @ObservedObject var searchTextWrapper: SearchTextObservable
//    @State var animate: Bool = false
//    
//    let placeholder: String
//    //var dismissButtonTitle: String
//    //var dismissButtonCallback: (() -> Void)?
//    
//    init(isSearching: Bool, searchTextWrapper: SearchTextObservable, animate: Bool, placeholder: String) {
//        self.isSearching = isSearching
//        self.searchTextWrapper = searchTextWrapper
//        self.animate = animate
//        self.placeholder = placeholder
//    }
//    
//    private var searchCancellable: Cancellable? = nil
//    
//    public var body: some View {
//        GeometryReader { reader in
//            HStack(alignment: .center, spacing: 0) {
//                Image(systemName: "magnifyingglass")
//                TextField(self.placeholder,
//                          text: self.$searchTextWrapper.searchText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                if !self.searchTextWrapper.searchText.isEmpty {
//                    Button(action: {
//                        self.searchTextWrapper.searchText = ""
//                        self.isSearching = false
//                        //dismiss
//                    }, label: {
//                        Text("Cancle").foregroundColor(.pink)
//                    })
//                    .buttonStyle(BorderlessButtonStyle())
//                    .animation(.easeInOut, value: animate)
//                    .onAppear { animate = true }
//                }
//            }
//            .padding(4)
//        }.frame(height: 44)
//    }
//}
