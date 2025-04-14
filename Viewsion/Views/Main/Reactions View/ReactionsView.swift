//
//  ReactionsView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/29/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ReactionsView: View {
    // Model for all the reactions for the movie by all users and this user
    @ObservedObject var reactionsVM: ReactionsViewModel
    
    var body: some View {
        VStack {
            
            Spacer(minLength: 15)
            // Reaction Picker Stack
            ReactionPickerStack()
            
            Divider()
            // Reaction Graph Stack
            ReactionGraphStack(vm: reactionsVM)
            
        }.font(.title3)
            .foregroundColor(.gray)
        
    }
}

struct ReactionsView_Previews: PreviewProvider {
    static let movieId: MovieId = MovieId(userId: "615d79f3c824adc50c1967e8", movieId: "616295932c243d7fec66cd36")
    
    static var previews: some View {
        AboutView()
    }
}

struct ReactionPickerStack: View {
    @ObservedObject var reactionsVM: ReactionsViewModel = ReactionsViewModel()
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                if (reactionsVM.reactions?.emojis != nil) {
                    ForEach((reactionsVM.reactions?.emojis)!, id:\.self) { emoji in
                        if reactionsVM.reactions?.userReaction == nil {
                            
                            Spacer()
                            Button(action: {
                                // Create reaction
                            }, label: {
                                // Emoji Button Label
                                Image(systemName: emoji.name!)
                            })
                            Spacer()
                            
                        } else {
                            if emoji.name != reactionsVM.reactions?.userReaction.name {
                                
                                Spacer()
                                Button(action: {
                                    // Update reaction
                                }, label: {
                                    // Emoji Button Label
                                    Image(systemName: emoji.name!)
                                })
                                Spacer()
                            } else {
                                Spacer()
                                Button(action: {
                                    // Delete reaction
                                }, label: {
                                    // Emoji Button Label
                                    Image(systemName: emoji.name! + ".fill")
                                })
                                Spacer()
                            }
                        }
                    }
                }
            }.padding()
        }.frame(height: 100)
    }
}

struct ReactionsPickerStack_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}

struct ReactionGraphStack: View {
    @ObservedObject var reactionsVM: ReactionsViewModel
    private let lineHeight: CGFloat = 10.0
    var rows: [ReactionRow] = []
    var color: [Color]
    var colorIndex: Int = 0
    
    init(vm: ReactionsViewModel) {
        reactionsVM = vm
        color = [Color.blue, Color.green, Color.red, Color.orange, Color.yellow,
                 Color.blue, Color.green, Color.red, Color.orange, Color.yellow,
                 Color.blue, Color.green, Color.red, Color.orange, Color.yellow,
                 Color.blue, Color.green, Color.red, Color.orange, Color.yellow,
                 Color.blue, Color.green, Color.red, Color.orange, Color.yellow]
    }
    
    var body: some View {
        ScrollView(.vertical) {
            HStack(spacing: 10) {
                if let rows = CreateReactionRows(reactionVM: reactionsVM) {
                    ForEach(rows.indices, id:\.self) { row in
                        Spacer()
                        Image(systemName: rows[row].emoji!)
                        ZStack {
                            Rectangle()
                                .fill(color[row])
                                .frame(width: rows[row].barWidth, height: lineHeight)
                        }
                        Spacer()
                        Text(rows[row].total!)
                        Spacer()
                    }
                }
            }.padding()
        }.frame(height: 100)
    }
    
    //Sets the bar width for the emoji graph
    func CreateReactionRows(reactionVM: ReactionsViewModel) -> [ReactionRow]? {
        var emojiArray: Array<Int> = []
        var reactionRows: [ReactionRow] = []
        let maxEmoji: Int
        var currentEmoji: Int = 0
        
        guard let _ = reactionsVM.emojiCategories else {
            return reactionRows
        }
        
        for item in reactionsVM.emojiCategories! {
            emojiArray.append(reactionVM.emojiCategories![item.key]!.count)
        }
        maxEmoji = emojiArray.max()!
        
        // Create Reaction Row
        for category in reactionsVM.emojiCategories! {
            let row = ReactionRow()
            currentEmoji = reactionVM.emojiCategories![category.key]!.count
            
            row.emoji = category.key
            row.total =  formatNumber(reactionVM.emojiCategories![category.key]!.count)
            //row.bar?.height = 10.0
            row.barWidth = GetBarWidth(total: CGFloat(currentEmoji), maxTotal: CGFloat(maxEmoji), minWidth: 10.0, maxWidth: 350.0)
            //row.bar?.color = row.bar?.colors[index]; index += 1
            
            reactionRows.append(row)
        }
        return reactionRows
    }
    
    func GetBarWidth(total: CGFloat, maxTotal: CGFloat, minWidth: CGFloat, maxWidth: CGFloat) -> CGFloat{
        let _ = minWidth
        let max = maxWidth
        let percentage = total / maxTotal
        let barWidth = max * percentage
        
        return barWidth
    }
    
}

struct ReactionsGraphStack_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}

struct ReactionRowView: View {
    var reactionRow: ReactionRow
    
    var body: some View {
        HStack {
            Image(systemName: "smiley")
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: CGFloat(25 * 10.0), height:   10.0)
            }
            Spacer()
            Text("727k")
            
        }
        
    }
}

struct ReactionRowView_Previews: PreviewProvider {
    static let row = ReactionRow(pEmoji: "smiley", pBarWidth: 300.0, pTotal: 35)
    
    static var previews: some View {
        ReactionRowView(reactionRow: row)
    }
}
