//
//  MeView.swift
//  HotProspects
//
//  Created by BizMagnets on 22/07/25.
//
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var qrCode = UIImage()
    var body: some View {
        NavigationStack{
            Form{
                TextField("name",text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("emailAddress",text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
        }
        .onAppear(perform: updateCode)
        .onChange(of: name, updateCode)
        .onChange(of: emailAddress, updateCode)
    }
    func updateCode() {
        qrCode = generateQr(from: "\(name)\n\(emailAddress)")
    }
    func generateQr(from string:String) ->UIImage{
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage{
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent)!
            return UIImage(cgImage: cgImage)
        }
        return UIImage()
    }
}

#Preview {
    MeView()
}
