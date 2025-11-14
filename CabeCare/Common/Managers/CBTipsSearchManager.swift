//
//  CBTipsSearchManager.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Searches for plant care tips online
//

import Foundation

class CBTipsSearchManager {
    static let shared = CBTipsSearchManager()

    private init() {}

    // Predefined tips about chili pepper care
    private let predefinedTips = [
        CBPlantTip(
            title: "Penyiraman Rutin",
            content: "Tanaman cabe memerlukan penyiraman rutin 1-2 kali sehari, terutama saat musim kemarau. Pastikan tanah tetap lembab tapi tidak tergenang air.",
            source: "Tips Budidaya Cabe"
        ),
        CBPlantTip(
            title: "Sinar Matahari",
            content: "Tanaman cabe memerlukan sinar matahari minimal 6-8 jam per hari untuk pertumbuhan optimal dan produksi buah yang maksimal.",
            source: "Panduan Perawatan Cabe"
        ),
        CBPlantTip(
            title: "Pemupukan",
            content: "Berikan pupuk NPK atau pupuk organik setiap 2 minggu sekali untuk nutrisi yang cukup. Gunakan pupuk dengan perbandingan N:P:K = 15:15:15.",
            source: "Teknik Pemupukan Cabe"
        ),
        CBPlantTip(
            title: "Drainase yang Baik",
            content: "Pastikan pot atau lahan memiliki drainase yang baik untuk mencegah akar membusuk. Gunakan media tanam yang gembur dan porous.",
            source: "Tips Media Tanam"
        ),
        CBPlantTip(
            title: "Pemangkasan Cabang",
            content: "Lakukan pemangkasan cabang yang tidak produktif atau terserang hama untuk meningkatkan sirkulasi udara dan fokus energi tanaman pada buah.",
            source: "Teknik Pemangkasan"
        ),
        CBPlantTip(
            title: "Pengendalian Hama",
            content: "Periksa tanaman secara rutin dari serangan hama seperti kutu daun, ulat, dan trips. Gunakan pestisida organik atau nabati untuk pengendalian.",
            source: "Pengendalian Hama Organik"
        ),
        CBPlantTip(
            title: "Suhu Ideal",
            content: "Tanaman cabe tumbuh optimal pada suhu 24-28°C. Lindungi tanaman dari suhu ekstrim yang dapat menghambat pertumbuhan.",
            source: "Kondisi Lingkungan Optimal"
        ),
        CBPlantTip(
            title: "Penyerbukan",
            content: "Bantu proses penyerbukan dengan menggoyangkan tanaman secara lembut atau menggunakan kuas kecil untuk memindahkan serbuk sari antar bunga.",
            source: "Teknik Penyerbukan"
        ),
        CBPlantTip(
            title: "Kelembaban Udara",
            content: "Jaga kelembaban udara sekitar 60-80% untuk pertumbuhan optimal. Semprotkan air ke daun saat udara terlalu kering.",
            source: "Manajemen Kelembaban"
        ),
        CBPlantTip(
            title: "Pemanenan",
            content: "Panen cabe saat buah sudah berwarna merah penuh atau sesuai varietas. Panen secara berkala untuk merangsang pembentukan buah baru.",
            source: "Panduan Pemanenan"
        )
    ]

    // Search for tips (simulated search with predefined tips)
    func searchTips(query: String, completion: @escaping ([CBPlantTip]) -> Void) {
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }

            // Filter tips based on query
            let normalizedQuery = query.lowercased()
            let results = self.predefinedTips.filter { tip in
                tip.title.lowercased().contains(normalizedQuery) ||
                tip.content.lowercased().contains(normalizedQuery)
            }

            // If no results, return random tips
            if results.isEmpty {
                let randomTips = Array(self.predefinedTips.shuffled().prefix(3))
                completion(randomTips)
            } else {
                completion(results)
            }
        }
    }

    // Get random tip
    func getRandomTip() -> CBPlantTip {
        return predefinedTips.randomElement() ?? predefinedTips[0]
    }

    // Get all tips
    func getAllTips() -> [CBPlantTip] {
        return predefinedTips
    }

    // Search and send notification
    func searchAndNotify(query: String) {
        searchTips(query: query) { tips in
            if let firstTip = tips.first {
                // Save to local storage
                CBDataManager.shared.addTip(firstTip)

                // Send notification
                CBNotificationManager.shared.sendTipNotification(tip: firstTip)
            }
        }
    }
}
