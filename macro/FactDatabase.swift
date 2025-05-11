//
//  FactDatabase.swift
//  macro
//
//  Created by Maryam Bahwal on 11/11/1446 AH.
//

import Foundation
struct FactPart {
    let sound: String
    let text: String
    let year: String
}

struct FactOption {
    let title: String
    let karma: Int
    let parts: [FactPart]
}

struct FactData {
    let fact: String
    let options: [FactOption] // exactly 2
}

struct FactDatabase {
    static func getFact(for category: String, mode: String, language: String) -> FactData {
        // Example only. Replace with real content.
        if category == "Art_in_History" && mode == "Horror" && language == "english" {
            return FactData(
                fact: "In ancient times, horror was used to shock mentally ill patients.",
                options: [
                    FactOption(title: "True", karma: 10, parts: [
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP1 Q1 ENGLISH.MP3", text: "Used in Egypt", year: "1800"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP1 Q2 ENGLISH.MP3", text: "Later in Europe", year: "1850"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP1 Q3 ENGLISH.MP3", text: "Now outdated", year: "1950")
                    ]),
                    FactOption(title: "False", karma: 5, parts: [
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q1 ENGLISH.MP3", text: "No proof", year: "1800"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q2 ENGLISH.MP3", text: "Myth spread", year: "1900"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q3 ENGLISH.MP3", text: "Still debated", year: "2000")
                    ])
                ]
            )
        }

        if category == "Art_in_History" && mode == "Horror" && language == "arabic" {
            return FactData(
                fact: "أصبحت لوحة برونو أماديو للطفل الذي يبكي مشهورة عالميا وأصبحت أسطورة بعد حرائق غامضة متكررة، حيث قيل إن كل مكان علقت فيه اللوحة اشتعلت فيه النيران دون أن يتعرض للأذى",
                options: [
                    FactOption(title: "اختار الفنان تجاهل الطفل الحقيقي الذي ألهم اللوحة ولم يؤويه", karma: 10, parts: [
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP1 Q1 ARABIC .MP3", text: "هناك اعتقاد بأنه أينما تم التغاضي عن طفل حزين، يظهر ظل صغير، يحدق من النافذة فيك ... لا يطلب شيئا سوى نظرة الرحمة. إذا لم تفعل ذلك، فإن المكان يحترق", year: "١٨٠٠"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP1 Q2 ARABIC .MP3", text:  "في بعض المتاحف، يتم وضع كرسي فارغ جانبا بجوار كل عمل فني يعتبر \"شعورا بالجفاف\"، مع النقش: \"لأولئك الذين تجاهلهم برونو\".", year: "١٨٥٠"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP1 Q3 ARABIC .MP3", text: "لم تعد الدموع في الفن رمزا للتعاطف، بل ترتبط بالخطر", year: "١٩٥٠")
                    ]),
                    FactOption(title: "وقف الطفل عند باب برونو وهو يبكي، ولكن من شدة ضحكه الهستيري", karma: 5, parts: [
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q1 ARABIC.MP3", text: "الأشخاص الذين يسمعون الصوت ضمن نطاق معين، يبدأون في البكاء دون تفسير", year: "١٨٠٠"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q2 ARABIC.MP3", text: "كلما اقتربت البشرية من كارثة كبيرة، أصبحت الضحكة في اللوحة أعلى قليلا ... ويبدأ الناس في الشعور بعدم الارتياح في الغرفة", year: "١٩٠٠"),
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q3 ARABIC.MP3", text: "المنازل التي تعلق اللوحة لا تحترق، لكن السكان يبدأون في الضحك حتى الموت.", year: "٢٠٠٠")
                    ])
                ]
            )
        }

        // Default
        return FactData(
            fact: "This is a fact.",
            options: [
                FactOption(title: "Option A", karma: 0, parts: []),
                FactOption(title: "Option B", karma: 0, parts: [])
            ]
        )
    }
}
