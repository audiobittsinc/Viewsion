//
//  UploadMovieView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct UploadMovieView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var genre = ""
    @State private var format = ""
    @State private var category = ""
    @State private var keywords = ""
    @State private var keywordsArray: [String] = []
    @State private var galleryFileUrl: URL = URL(fileURLWithPath: "")
    @State private var movieFileUrl: URL = URL(fileURLWithPath: "")
    @State private var showGalleryPicker = false
    @State private var showMoviePicker = false
    @State private var finalFileUrl: URL = URL(fileURLWithPath: "")
    @State private var galleryImportDisabled = false
    @State private var filesImportDisabled = false
    @State private var isThankYouVideo = false
    @State private var titleVal = ""
    @State private var descriptionVal = ""
    @State private var categoryVal = ""
    @State private var genreVal = ""
    @State private var keywordsVal = ""
    @State private var fileVal = ""
    private var movDoc = Movie()
    @ObservedObject private var viewModel = UploadViewModel()
    @State var signInRequired: Bool = false
    
    var body: some View {
        if(isThankYouVideo) {
            ZStack {
                Color.blue
                VStack {
                    Form {
                        Group {
                            VStack {
                                Picker(selection: $category,
                                       label: Text("Category").foregroundColor(.primary)) {
                                    ForEach(movieCategory.allCategories, id: \.self) { cat in
                                        Text(cat).tag(cat)
                                    }
                                }
                                if !categoryVal.isEmpty {
                                    Text(categoryVal)
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                            }
                            Group {
                                VStack {
                                    HStack {
                                        if(movieFileUrl.absoluteURL.path != "/") {
                                            Text(movieFileUrl.lastPathComponent)
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack {
                                        Button("Import Movie From Files") {
                                            showMoviePicker = true
                                            galleryFileUrl = URL(fileURLWithPath: "")
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                        .disabled(filesImportDisabled)
                                        .sheet(isPresented: $showMoviePicker, content: {
                                            MoviePicker(fileUrl: $movieFileUrl)
                                                .edgesIgnoringSafeArea(.all)
                                            
                                        })
                                        Spacer()
                                        Button("Clear") {
                                            viewModel.deleteFileAfterUpload(url: movieFileUrl)
                                            movieFileUrl = URL(fileURLWithPath: "")
                                            
                                        }.buttonStyle(BorderlessButtonStyle())
                                            .font(.body)
                                        HStack {
                                            if !fileVal.isEmpty {
                                                Text(fileVal)
                                                    .foregroundColor(.red)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                            Group {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Button(action: {
                                            keywordsArray = getCommaSeparatedValues(keywords: keywords)
                                            if vUserId == "" {
                                                signInRequired = true
                                                return
                                            }
                                            if galleryFileUrl == URL(fileURLWithPath: "") {
                                                finalFileUrl = movieFileUrl
                                            } else if movieFileUrl == URL(fileURLWithPath: "") {
                                                finalFileUrl = galleryFileUrl
                                            }
                                            if (isUploadInformationValid()) {
                                                getMovieFromForm()
                                                viewModel.UploadMovie(movie: viewModel.movie, fileURL: finalFileUrl)
                                            }
                                        }, label: {
                                            Text(viewModel.isUploading ? "Please wait" : "Upload")
                                                .font(.title)
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle())
                                                .opacity(viewModel.isUploading ? 1.0 : 0.0)
                                        })
                                            .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color(.sRGB, red: 0, green: 1, blue: 1, opacity: 0.5))
                    }.padding()
                }
                .navigationTitle("Thank You Video")
                .font(.title3)
                .background(Color.blue)
                .onAppear(perform: {
                    isThankYouSelected()
                })
                .onChange(of: category, perform: { value in
                    if(category == "Thank you") {
                        isThankYouVideo = true
                    } else {
                        isThankYouVideo = false
                    }
                })
            }
        } else {
            ZStack {
                Color.blue
                VStack {
                    Form {
                        Group {
                            Group {
                                Picker(selection: $category,
                                       label: Text("Category").foregroundColor(.primary)) {
                                    ForEach(movieCategory.allCategories, id: \.self) { cat in
                                        Text(cat).tag(cat)
                                    }
                                }
                                if !categoryVal.isEmpty {
                                    HStack {
                                        Text(categoryVal)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("Title:")
                                            .disabled(isThankYouVideo)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    TextField("Title",
                                              text: $title).foregroundColor(.secondary)
                                        .disabled(isThankYouVideo)
                                    HStack {
                                        if !titleVal.isEmpty {
                                            Text(titleVal)
                                                .foregroundColor(.red)
                                            Spacer()
                                        }
                                    }
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("Description:")
                                            .disabled(isThankYouVideo)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    TextField("Description", text: $description)
                                        .disabled(isThankYouVideo)
                                        .foregroundColor(.secondary)
                                    HStack {
                                        if !descriptionVal.isEmpty {
                                            Text(descriptionVal)
                                                .foregroundColor(.red)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            Group {
                                Picker(selection: $genre,
                                       label: Text("Sub Category/Genre").foregroundColor(.primary)) {
                                    ForEach(movieGenre.allGenres, id: \.self) { genre in
                                        Text(genre).tag(genre)
                                    }
                                }
                                if !genreVal.isEmpty {
                                    HStack {
                                        Text(genreVal)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                }
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("Keywords:")
                                            .disabled(isThankYouVideo)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    TextField("one,two,three",
                                              text: $keywords)
                                        .disabled(isThankYouVideo)
                                        .foregroundColor(.secondary)
                                    HStack {
                                        if !keywordsVal.isEmpty {
                                            Text(keywordsVal)
                                                .foregroundColor(.red)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            Group {
                                VStack {
                                    HStack {
                                        if(movieFileUrl.absoluteURL.path != "/") {
                                            Text(movieFileUrl.lastPathComponent)
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack {
                                        Button("Import Movie From Files") {
                                            showMoviePicker = true
                                            galleryFileUrl = URL(fileURLWithPath: "")
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                        .disabled(filesImportDisabled)
                                        .sheet(isPresented: $showMoviePicker, content: {
                                            MoviePicker(fileUrl: $movieFileUrl)
                                                .edgesIgnoringSafeArea(.all)
                                        })
                                        Spacer()
                                        Button("Clear") {
                                            viewModel.deleteFileAfterUpload(url: movieFileUrl)
                                            movieFileUrl = URL(fileURLWithPath: "")
                                        }.buttonStyle(BorderlessButtonStyle())
                                            .font(.body)
                                    }
                                }
                            }
                            if !fileVal.isEmpty {
                                HStack {
                                    Text(fileVal)
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                            }
                            Group {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Button(action: {
                                            keywordsArray = getCommaSeparatedValues(keywords: keywords)
                                            if vUserId == "" {
                                                signInRequired.toggle()
                                                return
                                            }
                                            if galleryFileUrl == URL(fileURLWithPath: "") {
                                                finalFileUrl = movieFileUrl
                                            } else if movieFileUrl == URL(fileURLWithPath: "") {
                                                finalFileUrl = galleryFileUrl
                                            }
                                            if (isUploadInformationValid()) {
                                                getMovieFromForm()
                                                viewModel.UploadMovie(movie: viewModel.movie, fileURL: finalFileUrl)
                                            }
                                        }, label: {
                                            Text(viewModel.isUploading ? "Please wait" : "Upload")
                                                .font(.title)
                                        })
                                            .buttonStyle(BorderlessButtonStyle())
                                            .disabled(isMovieUploading)
                                            .alert("Please Sign In", isPresented: $signInRequired) {
                                                Button("OK", role: .cancel) { }
                                            }
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                            .opacity(viewModel.isUploading ? 1.0 : 0.0)
                                            .foregroundColor(Color.secondary)
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color(.sRGB, red: 0, green: 1, blue: 1, opacity: 0.5))
                    }
                    .padding()
                    .navigationTitle("Upload Movie")
                    .font(.title3)
                }
                
                .onAppear(perform: {
                    isThankYouSelected()
                })
                .onChange(of: category, perform: { value in
                    if(category == "Thank you") {
                        isThankYouVideo = true
                    } else {
                        isThankYouVideo = false
                    }
                })
                .alert("Please Sign In", isPresented: $signInRequired) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Upload Completed Successfully", isPresented: $viewModel.movieUploaded) {
                    Button("OK", role: .cancel) { clearForm() }
                }
            }
        }
    }
    
    private func isUploadInformationValid() -> Bool {
        if (category.isEmpty && category != "Thank you") {
            categoryVal = "Select a category."
            return false
        } else {
            categoryVal = ""
        }
        if (title.isEmpty && category != "Thank you") {
            titleVal = "Enter a title."
            return false
        } else {
            titleVal = ""
        }
        if (description.isEmpty && category != "Thank you") {
            descriptionVal = "Enter a description."
            return false
        } else {
            descriptionVal = ""
        }
        if (genre.isEmpty && category != "Thank you"){
            genreVal = "Select a sub category/genre."
            return false
        } else {
            genreVal = ""
        }
        if (keywords.isEmpty && category != "Thank you") {
            keywordsVal = "Enter the keywords."
            return false
        } else {
            keywordsVal = ""
        }
        if galleryFileUrl.path == "/" && movieFileUrl.path == "/" {
            fileVal = "Select a movie from Gallery or Files."
            return false
        } else {
            fileVal = ""
        }
        return true
    }
    
    func getCommaSeparatedValues(keywords: String) -> [String] {
        var valueArray: [String]
        valueArray = keywords.components(separatedBy: ",")
        return valueArray
    }
    
    func getMovieFromForm() {
        self.viewModel.movie.creatorId = vUserId
        self.viewModel.movie.title = title
        self.viewModel.movie.description = description
        self.viewModel.movie.category = category.lowercased()
        self.viewModel.movie.genre = genre
        self.viewModel.movie.keywords = keywordsArray
    }
    
    func clearForm() {
        title = ""
        description = ""
        category = ""
        genre = ""
        keywords = ""
        movieFileUrl = URL(fileURLWithPath: "")
        galleryFileUrl = URL(fileURLWithPath: "")
    }
    
    func isThankYouSelected() {
        if category == "Thank you" {
            isThankYouVideo = true
        } else {
            isThankYouVideo = false
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    private var isMovieUploading: Bool {
        viewModel.isUploading
    }
    
}

struct UploadMovieView_Previews: PreviewProvider {
    static var previews: some View {
        UploadMovieView()
    }
}

struct movieGenre {
    static let allGenres = [
        "Action",
        "Adventure",
        "Comedy",
        "Drama",
        "Horror",
        "Monologue",
        "Vlog",
        "Story",
        "Skit",
        "Short Movie",
        "Feature Film",
        "Show",
        "Music",
        "Religious",
        "Other"
    ]
}

struct movieCategory {
    static let allCategories = [
        "Movie",
        "Highlight",
        "Thank you"
    ]
}

struct movieFormat {
    static let allFormats = [
        "Vertical",
        "Horizontal"
    ]
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Background<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.white
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}



