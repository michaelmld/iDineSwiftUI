//
//  ItemDetail.swift
//  DrDogSwiftUi
//
//  Created by michael dang on 10/3/21.
//

import SwiftUI

struct ItemDetail: View {
    
    //Hooks us up to Order that is being observed
    //IF this thing changes, refresh my view
    @EnvironmentObject var order: Order
    
    let item: MenuItem
    
    var body: some View {
        VStack {
            //Depth stack
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
                //Order matters for modifiers since they run in order
            }
            Text(item.description)
                .padding()
            Button("Order This"){
                order.add(item: item)
            }
            .font(.headline)
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}
