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
                fact: "Bruno Amadeo's painting of the Crying Child became world-famous and became a legend after repeated mysterious fires, in which it was said that every place where the painting was hung caught fire without it being harmed.",
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
        if category == "Art_in_History" && mode == "Comics" && language == "english" {
            return FactData(
                fact: "Bruno Amadeo's painting of the Crying Child became world-famous and became a legend after repeated mysterious fires, in which it was said that every place where the painting was hung caught fire without it being harmed.",
                options: [
                    FactOption(title: "The child Bruno drew was the body borrowed from a passion demon called (Weeprax).", karma: 10, parts: [
                        FactPart(sound: "ART IN HISTORY_Comics Mode_OP1 Q1 ENGLISH.MP3", text: "When Bruno completed the painting, the entity was not imprisoned... but was copied into every edition.", year: "1800"),
                        FactPart(sound: "ART IN HISTORY_Comics Mode_OP1 Q2 ENGLISH.MP3", text: "A dark figure called (The Curator) emerges, a mysterious individual who gathers the paintings to fully awaken Weeprax, turning the world into a burning arena of collective pain.", year: "1850"),
                        FactPart(sound: "ART IN HISTORY_Comics Mode_OP1 Q3 ENGLISH.MP3", text: "Simply looking at the painting for a long time produces what is known as a (Sympathetic Burn)—a burning of emotions rather than bodies. The person sees the fire on their skin, but it doesn't hurt them. They hear their own voice screaming, but don't speak. They remember their childhood as tragic... even if it wasn't.", year: "1950")
                    ]),
                    FactOption(title: "Bruno was no ordinary painter... He was part of a mysterious organization called The Brushline.", karma: 5, parts: [
                        FactPart(sound: "ART IN HISTORY_Comics Mode_OP2 Q1 ENGLISH .MP3", text: "When Bruno painted (The Crying Child,) he didn't just paint him; he trapped a fiery, angry entity within layers of paint. Instead of letting the child's powers explode, Bruno sealed them into the canvas, saving the world from a spiritual holocaust.", year: "1800"),
                        FactPart(sound: "ART IN HISTORY_Comics Mode_OP2 Q2 ENGLISH.MP3", text: "A superhuman child named Echo is born with the ability to absorb the sadness from people... but he dies slowly if he doesn't feel pain.", year: "1900"),
                        FactPart(sound: "ART IN HISTORY_Comics Mode_OP2 Q3 ENGLISH.MP3", text: "A heroine named (Ashra) appears in front of the painting, an orphan whose house burned down but escaped unharmed... and it turns out that she's the only one who can hear the child inside the painting. She's the only one who can save Echo from death.", year: "2000")
                    ])
                ]
            )
        }
        
        if category == "Art_in_History" && mode == "Comics" && language == "arabic" {
            return FactData(
                fact: "أصبحت لوحة برونو أماديو للطفل الذي يبكي مشهورة عالميا وأصبحت أسطورة بعد حرائق غامضة متكررة، حيث قيل إن كل مكان علقت فيه اللوحة اشتعلت فيه النيران دون أن يتعرض للأذى",
                options: [
                    FactOption(title: "كان الطفل الذي رسمه برونو هو الجثة المستعارة من شيطان العاطفة المسمى ويبراكس", karma: 10, parts: [
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

        if category == "Legendsـ&ـMyths" && mode == "Horror" && language == "english" {
            return FactData(
                fact: "Vlad III, known as Vlad the Impaler, was a Romanian prince known for his brutal methods of punishment.",
                options: [
                    FactOption(title: "Vlad becomes a loyal servant of the Ottomans", karma: 10, parts: [
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP1 Q1 ENGLISH .MP3", text: "Uses ( impalement ) methods against European nobles in conquered territories, and is known as the ( Sultan of Shadows ).", year: "1465"),
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP1 Q2 ENGLISH.MP3", text: "Rome is besieged by Vlad, who enters it at night. It is said that he made the Pope cry with fear.", year: "1512"),
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP1 Q3 ENGLISH.MP3", text: "Vlad is worshipped as a dark god in some cults, and shrines are built for him from the skulls of enemies.", year: "1800")
                    ]),
                    FactOption(title: "vlad is born into a peacful aristocratic family", karma: 5, parts: [
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP2 Q1 ENGLISH.MP3", text: "Changing the course of Ottoman history, which may delay the fall of Constantinople or make their expansion more difficult.", year: "1453"),
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP2 Q2 ENGLISH.MP3", text: "Anyone suspected of corresponding with the Ottomans, of having an emotional tendency that led to rebellion, or of rejecting the principle of “Vlad’s rationality” was dragged from his home at night… and not returned.", year: "1460"),
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP2 Q3 ENGLISH.MP3", text: "The legend of Dracula never appeared.", year: "1700")
                    ])
                ]
            )
        }
        

        if category == "Legendsـ&ـMyths" && mode == "Comics" && language == "english" {
            return FactData(
                fact: "Vlad III, known as Vlad the Impaler, was a Romanian prince known for his brutal methods of punishment.",
                options: [
                    FactOption(title: "Vlad chooses to immortalize himself... through pain.", karma: 10, parts: [
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP1 Q1 ENGLISH.MP3", text: "The  ( Seven Peg Order ) was founded. This was a bloody, doctrinal covenant that used pain as a method of purification and control over people through codified emotional rituals.", year: "1455"),
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP1 Q2 ENGLISH.MP3", text: "The “Cities of Pain” are founded. The first city is built entirely according to the teachings of the Seven Stakes.", year: "1457"),
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP1 Q3 ENGLISH.MP3", text: "The first generation of ( Purifiers ) appears, a special unit called ( The Bleeding Guard ) trained to use fear and psychological defeat instead of swords.", year: "1464")
                    ]),
                    FactOption(title: "Vlad chooses to be the Great Protector... through order, not subjugation.", karma: 5, parts: [
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP2 Q1 ENGLISH.MP3", text: "( The Charter of Popular Defense ) - a social-military justice system that makes the people partners in governing and defending the kingdom.", year: "1458"),
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP2 Q2 ENGLISH.MP3", text: "( Nights of Revelation) Every year, for three nights, people are asked to write down their thoughts and concerns anonymously, and these are read out loud.", year: "1468"),
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP2 Q3 ENGLISH.MP3", text: "2025 AD – Vlad's legacy is revived through an international organization called “VIGIL,” headquartered inside an ancient castle in Transylvania... and its doors are only opened one night every 10 years.", year: "2025")
                    ])
                ]
            )
        }
        
        
        
   
        if category == "Legendsـ&ـMyths" && mode == "Horror" && language == "arabic" {
            return FactData(
                fact: "فلاد الثالث، المعروف بفلاد المخوزق، كان أميرًا رومانيًا اشتهر بطرق عقوباته القاسية والوحشية.",
                options: [
                    FactOption(title: "أصبح فلاد خادما مخلصا للعثمانيين", karma: 10, parts: [
                      
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP1 Q1 ARABIC.MP3", text: "يستخدم طرق ( التعذيب بالخشب ) ضد النبلاء الأوروبيين في الأراضي التي استولى عليها، ويُعرف بلقب ( سلطان الظلال ).", year: "١٤٦٥"),
                      
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP1 Q2 ARABIC.MP3", text:  "تُحاصر روما على يد فلاد، الذي يدخلها ليلاً. ويُقال إنه جعل البابا يبكي من شدة الخوف.", year: "١٥١٢"),
                       
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP1 Q3 ARABIC .MP3", text: "يُعبَد فلاد كإله مظلم في بعض الطوائف، وتُبنى له معابد من جماجم الأعداء.", year: "١٨٠٠")
                    ]),
                    FactOption(title: "ولد فلاد في عائلة أرستقراطية مسالمة", karma: 5, parts: [
                     
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP2 Q1 ARABIC.MP3", text: "تغيير مسار تاريخ العثمانيين، مما قد يؤخر سقوط القسطنطينية أو يجعل توسعهم أكثر صعوبة.", year: "١٤٥٣"),
                       
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP2 Q2 ARABIC.MP3", text: "أي شخص يُشتبه في مراسلته مع العثمانيين، أو في امتلاكه ميلاً عاطفيًا أدى إلى التمرد، أو في رفضه مبدأ  ( عقلانية فلاد )، كان يُسحب من منزله ليلاً ...  ولا يعود", year: "١٤٦٠"),
                      
                        FactPart(sound: "LEGENDS & MYTHS_Horror Mode_OP2 Q3 ARABIC.MP3", text: "لم تظهر أسطورة دراكولا أبدًا.", year: "١٧٠٠")
                    ])
                ]
            )
        }
        
        if category == "Legendsـ&ـMyths" && mode == "Comics" && language == "arabic" {
            return FactData(
                fact: "فلاد الثالث، المعروف بفلاد المخوزق، كان أميرًا رومانيًا اشتهر بطرق عقوباته القاسية والوحشية.",
                options: [
                    FactOption(title: "عام 1700 ميلادي: لم تظهر أسطورة دراكولا أبدًا. اختار فلاد أن يخلد نفسه... من خلال الألم.", karma: 10, parts: [
                      
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP1 Q1 ARABIC.MP3", text: "تم تأسيس ( دستور السبعة أوتاد ). كان هذا تعاهدًا دمويًا دينيًا يستخدم الألم كوسيلة للتطهير والسيطرة على الناس من خلال طقوس عاطفية محددة بالقانون.", year: "١٤٥٥"),
                     
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP1 Q2 ARABIC.MP3", text:  "تم تأسيس ( مدن الألم ). تم بناء أول مدينة بالكامل وفقًا لتعاليم دستور السبعة أوتاد.", year: "١٤٥٧"),
                     
                        FactPart(sound: "LEGENDS & MYTHS_Comics Mode_OP1 Q3 ARABIC .MP3", text: "يظهر أول جيل من ( المطهّرين )، وهي وحدة خاصة تُدعى ( الحرس النازف )، تم تدريبها على استخدام الخوف والهزيمة النفسية بدلاً من السيوف.", year: "١٤٦٤")
                    ]),
                    FactOption(title: "يختار فلاد أن يكون ( الحامي الأكبر )... من خلال النظام، لا من خلال الاستعباد.", karma: 5, parts: [
                   
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q1 ARABIC.MP3", text: "( ميثاق الدفاع الشعبي ) - نظام عدالة اجتماعي-عسكري يجعل الناس شركاء في حكم المملكة والدفاع عنها.", year: "١٤٥٨"),
                     
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q2 ARABIC.MP3", text: "( ليالي الوحي ) – كل عام، لمدة ثلاث ليالٍ، يُطلب من الناس كتابة أفكارهم وهمومهم بشكل مجهول، ثم تُقرأ هذه الكتابات بصوت عالٍ.", year: "١٤٦٨"),
                     
                        FactPart(sound: "ART IN HISTORY_Horror Mode_OP2 Q3 ARABIC.MP3", text: "يتم إحياء إرث فلاد من خلال منظمة دولية تسمى ( فيجل )، ومقرها داخل قلعة قديمة في ترانسيلفانيا ... وتفتح أبوابها ليلة واحدة فقط كل 10 سنوات.", year: "٢٠٢٥")
                    ])
                ]
            )
        }
        
        
        
        if category == "Medicineـ&ـMind" && mode == "Utopian/Dystopian" && language == "english" {
            return FactData(
                fact: "In the late 19th century, cocaine was widely used as a painkiller — even in over-the-counter medicines and teething products for children. It wasn’t until the early 20th century that its addictive effects were truly recognized",
                options: [
                    FactOption(title: "", karma: 10, parts: [
                        FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP1 Q1 ENGLISH.MP3", text: "Cocaine becomes a staple in every household’s medicine cabinet. Mothers regularly offer ( calming syrup ) to children without question.", year: "1920"),
                     
                        FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP1 Q2 ENGLISH.MP3", text: "Soldiers in a new war refer to themselves as “Shadow Troops.” Some disappear, others claim the drug has “shut off their humanity.”", year: "1978"),
                      
                        FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP1 Q3 ENGLISH.MP3", text: "Scientists discover that an entire generation has lost the ability to feel. The phenomenon is named “Emotional Vacuum Syndrome.”", year: "2028")
                    ]),
                    FactOption(title: "What if it was banned… but only in the 2000s?", karma: 5, parts: [
                        FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP2 Q1 ENGLISH.MP3", text: "Cocaine dominates the market: “Power Pills for Parents” and “Brain Boosters for Kids” become cultural staples.", year: "1960–1990"),
                      
                        FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP2 Q2 ENGLISH.MP3", text: "A viral video of a child hallucinating on cocaine cough syrup sparks global outrage", year: "2003"),
                     
                        FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP2 Q3 ENGLISH.MP3", text: "The first “Mind Olympics” are held but later banned due to misuse and dangerous psychological effects", year: "2012")
                    ])
                ]
            )
        }
        
        
        
        if category == "Medicineـ&ـMind" && mode == "Comics" && language == "english" {
             return FactData(
                 fact: "In the late 19th century, cocaine was widely used as a painkiller — even in over-the-counter medicines and teething products for children. It wasn’t until the early 20th century that its addictive effects were truly recognized",
                 options: [
                     FactOption(title: "What if cocaine continued to be used medically and was developed to enhance the human mind?", karma: 10, parts: [
                         FactPart(sound: "MEDICINE & MIND_Comics Mode_OP1 Q1 ENGLISH.MP3", text: "In the midst of World War II, secret European labs launch the “Coca Serum” project. Elite soldiers are injected with a chemical that boosts thinking speed and reflexes. Some become faster than sound—but most lose their memories and emotions over time.", year: "1942"),
                      
                         FactPart(sound: "MEDICINE & MIND_Comics Mode_OP1 Q2 ENGLISH.MP3", text: "After decades underground, survivors emerge as the Minds of the Shadow, executing covert missions that spread emotional chaos across global capitals. Entire populations begin losing free will under psychological manipulation waves.", year: "1987"),
                       
                         FactPart(sound: "MEDICINE & MIND_Comics Mode_OP1 Q3 ENGLISH.MP3", text: "A silent war erupts: Rationalist governments strive to protect natural human will, while mentally-enhanced rebels lead a revolution aiming to create a new world order ruled by superior minds.", year: "2029")
                     ]),
                     FactOption(title: "What if cocaine was banned early, and all research was redirected to building tools that strengthened the mind instead of numbing it?.", karma: 5, parts: [
                         FactPart(sound: "MEDICINE & MIND_Comics Mode_OP2 Q1 ENGLISH.MP3", text: "A scientist named Lamy Gray launches a global campaign against cocaine. The first medical lab based on it is shut down, and focus shifts to mental enhancement without substances", year: "1901"),
                       
                         FactPart(sound: "MEDICINE & MIND_Comics Mode_OP2 Q2 ENGLISH.MP3", text: "A new tech emerges—Mental Shadows—wearable devices that increase self-awareness and protect the brain from psychological collapse", year: "1963"),
                      
                         FactPart(sound: "MEDICINE & MIND_Comics Mode_OP2 Q3 ENGLISH.MP3", text: "The world adopts a dual-path education system: one stream focuses on emotional-mind intelligence, and the other integrates tech to shield cognition. Suicide rates drop to the lowest level in 150 years.", year: "2025")
                     ])
                 ]
             )
         }
         
        if category == "Medicineـ&ـMind" && mode == "Utopian/Dystopian" && language == "arabic" {
              return FactData(
                  fact: "في أواخر القرن التاسع عشر، كان الكوكايين يُستخدم على نطاق واسع كمسكن للألم — حتى في الأدوية التي تُصرف دون وصفة طبية ومنتجات التسنين للأطفال. ولم يُدرك تأثيراته الإدمانية إلا في أوائل القرن العشرين.",
                  options: [
                      FactOption(title: "ماذا لو لم يُحظر الكوكايين وظل مسكن ألم قانونيًا؟", karma: 10, parts: [
                        
                          FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP1 Q1 ARABIC.MP3", text: "يصبح الكوكايين جزءًا أساسيًا في خزانة الأدوية في كل منزل. الأمهات يعرضن ( شراب التهدئة ) للأطفال بانتظام دون تساؤل.", year: "١٩٢٠"),
                       
                          FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP1 Q2 ARABIC.MP3", text:  "يطلق جنود في حرب جديدة على أنفسهم اسم قوات الظل. بعضهم يختفي، بينما يدّعي آخرون أن العقار أطفأ إنسانيتهم.", year: "١٩٧٨"),
                       
                          FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP1 Q3 ARABIC .MP3", text: "يكتشف العلماء أن جيلًا كاملاً قد فقد القدرة على الشعور. وتسمى هذه الظاهرة ( متلازمة الفراغ العاطفي ).", year: "٢٠٢٨")
                      ]),
                      FactOption(title: "ماذا لو تم حظر الكوكايين... ولكن فقط في العقد ٢٠٠٠؟", karma: 5, parts: [
                     
                          FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP2 Q1 ARABIC.MP3", text: "يهيمن الكوكايين على السوق: ( حبوب القوة للآباء ) و ( منشطات الدماغ للأطفال ) تصبح من الأساسيات الثقافية.", year: "١٩٦٠-١٩٩٠"),
                       
                          FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP2 Q2 ARABIC.MP3", text: "فيديو فيروسي لطفل يهلوس على شراب السعال المخلوط بالكوكايين يثير غضبًا عالميًا.", year: "٢٠٠٣"),
                       
                          FactPart(sound: "MEDICINE & MIND_Utopian : Dystopian Mode_OP2 Q3 ARABIC", text: "أقيمت أول أولمبياد العقل، ولكن يتم حظرها لاحقًا بسبب سوء استخدامها وآثارها النفسية الخطيرة.", year: "٢٠١٢")
                      ])
                  ]
              )
          }
        
        
        if category == "Medicineـ&ـMind" && mode == "Comics" && language == "arabic" {
              return FactData(
                  fact: "في أواخر القرن التاسع عشر، كان الكوكايين يُستخدم على نطاق واسع كمسكن للألم — حتى في الأدوية التي تُصرف دون وصفة طبية ومنتجات التسنين للأطفال. ولم يُدرك تأثيراته الإدمانية إلا في أوائل القرن العشرين.",
                  options: [
                      FactOption(title: "ماذا لو استمر استخدام الكوكايين طبيا وتم تطويره لتعزيز العقل البشري؟", karma: 10, parts: [
                        
                          FactPart(sound: "MEDICINE & MIND_Comics Mode_OP1 Q1 ARABIC.MP3", text: "في خضم الحرب العالمية الثانية، تطلق المختبرات السرية الأوروبية مشروع ( مصل الكوك ).  يتم حقن الجنود النخبة بمادة كيميائية تعزز سرعة التفكير وردود الفعل. يصبح البعض أسرع من الصوت — لكن معظمهم يفقدون ذاكرتهم ومشاعرهم مع مرور الوقت.", year: "١٩٤٢"),
                       
                          FactPart(sound: "MEDICINE & MIND_Comics Mode_OP1 Q2 ARABIC.MP3", text:  "بعد عقود من الاختفاء تحت الأرض، يظهر الناجون كـ ( عقول الظل )، وينفذون مهام سرية تنشر الفوضى العاطفية عبر عواصم العالم. تبدأ الشعوب بأكملها في فقدان الإرادة الحرة تحت موجات من التلاعب النفسي.", year: "١٩٨٧"),
                       
                          FactPart(sound: "MEDICINE & MIND_Comics Mode_OP1 Q3 ARABIC.MP3", text: "تندلع حرب صامتة: تسعى الحكومات العقلانية لحماية الإرادة البشرية الطبيعية، بينما يقود المتمردون المعززون عقليًا ثورة تهدف إلى إنشاء نظام عالمي جديد تحكمه العقول المتفوقة.", year: "٢٠٢٩")
                      ]),
                      FactOption(title: "ماذا لو تم حظر الكوكايين في وقت مبكر، وتم تحويل جميع الأبحاث نحو بناء أدوات تقوي العقل بدلاً من تخديره؟", karma: 5, parts: [
                     
                          FactPart(sound: "MEDICINE & MIND_Comics Mode_OP2 Q1 ARABIC.MP3", text: "عالم يُدعى لامي غراي يطلق حملة عالمية ضد الكوكايين. يتم إغلاق أول مختبر طبي قائم عليه، ويتم تحويل التركيز نحو تعزيز العقل دون استخدام المواد.", year: "١٩٠١"),
                       
                          FactPart(sound: "MEDICINE & MIND_Comics Mode_OP2 Q2 ARABIC.MP3", text: "تظهر تقنية جديدة ( الظلال العقلية ) أجهزة قابلة للارتداء تزيد من الوعي الذاتي وتحمي الدماغ من الانهيار النفسي.", year: "١٩٦٣"),
                       
                          FactPart(sound: "MEDICINE & MIND_Comics Mode_OP2 Q3 ARABIC.MP3", text: "يتبنى العالم نظام تعليم ذا مسارين: أحدهما يركز على الذكاء العاطفي والعقلي، والآخر يدمج التكنولوجيا لحماية الإدراك. تنخفض معدلات الانتحار إلى أدنى مستوى لها في 150 عامًا.", year: "٢٠٢٥")
                      ])
                  ]
              )
          }
        
        if category == "Human_Rights" && mode == "Horror" && language == "english" {
                    return FactData(
                        fact: "n the Victorian era, children were forced to work hard in factories, mines, and fields from a very early age, under inhumane conditions, and without rights.",
                        options: [
                            FactOption(title: "Enforce The Black Hand Pact", karma: 10, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP1 Q1 ENGLISH.MP3", text: "Any child born in the industrial zone is considered the legal property of the factory until he or she reaches adulthood.", year: "1849"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP1 Q2 ENGLISH.MP3", text: "Children were not registered by their names... but by numbers engraved on their arms.", year: "1850"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP1 Q3 ENGLISHH.MP3", text: "In a coal mine, a sub-tunnel is discovered filled with the bodies of children that were never reported.", year: "1866")
                            ]),
                            FactOption(title: "Enforce a law prohibiting child labor in factories", karma: 5, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP2 Q1 ENGLISH.MP3", text: "Disappearances In dozens of institutions, children are locked in at night... and disappear without the lock being broken.", year: "1860"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP2 Q2 ENGLISH.MP3", text: "Childhood crime decreased by 60% because children no w had schools, shelters, and care, not streets and chimne ys.", year: "1870"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP2 Q3 ENGLISH.MP3", text: "At St. Ruth's Institution, all the tutors are found dead one foggy morning, their eyes wide open and their tongues tied with black string. ", year: "1870")
                            ])
                        ]
                    )
                }

                if category == "Human_Rights" && mode == "Horror" && language == "arabic" {
                    return FactData(
                        fact: "في العصر الفيكتوري، كان يُجبر الأطفال على العمل الشاق في المصانع والمناجم والمزارع منذ سن مبكرة، تحت ظروف غير إنسانية ودون أي حقوق.",
                        options: [
                            FactOption(title: "تطبيق اتفاقية اليد السوداء", karma: 10, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP1 Q1 ARABIC.MP3", text: " يُعتبر أي طفل يولد داخل المنطقة الصناعية ملكًا رسميًا للمصنع، ولا يُسمح له بالمغادرة حتى يبلغ سن الرشد.", year: "١٨٤٩"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP1 Q2 ARABIC.MP3", text:  "لا يتم تسجيل الأطفال بأسمائهم... بل بأرقام منقوشة على أذرعهم.", year: "١٨٥٠"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP1 Q3 ARABIC .MP3", text: " في أحد مناجم الفحم، يتم اكتشاف نفق فرعي مليء بجثث أطفال لم يتم الإبلاغ عنهم أبدًا.", year: "١٨٦٦")
                            ]),
                            FactOption(title: "سنّ قانون يمنع تشغيل الأطفال في المصانع.", karma: 5, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP2 Q1 ARABIC .MP3", text: " تبدأ حالات اختفاء غامضة في عدد من المؤسسات... يُغلق على الأطفال ليلاً، لكنهم يختفون دون أن تُكسر الأقفال.", year: "١٨٦٠"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP2 Q2 ARABIC.MP3", text: "تنخفض جرائم الطفولة بنسبة 60٪ بعد أن أصبح لدى الأطفال مدارس وملاجئ ورعاية، بدلًا من الشوارع والمداخن.", year: "١٨٧٠"),
                                FactPart(sound: "HUMAN RIGHTS_Horror Mode_OP2 Q3 ARABIC.MP3", text: " في إحدى الصباحات الضبابية، يُعثر على جميع المعلمين في مؤسسة سانت روث موتى، وعيونهم مفتوحة وألسنتهم مربوطة بخيط أسود", year: "١٨٧٠")
                            ])
                        ]
                    )
                }
                
                if category == "Human_Rights" && mode == "Utopian/Dystopian" && language == "english" {
                    return FactData(
                        fact: "n the Victorian era, children were forced to work hard in factories, mines, and fields from a very early age, under inhumane conditions, and without rights.",
                        options: [
                            FactOption(title: "The government issues a decree on the Eradicating Grief project.", karma: 10, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP1 Q1 ENGLISH.MP3", text: "The first wave of mass collapse of the forced smile generation followed by the emergence of a resistance group called The Tearful, who demand the return of sadness as a human right.", year: "1950"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP1 Q2 ENGLISH.MP3", text: "Patients begin drawing scratches on their faces to create a sense of a past that is no longer present in their memory.", year: "1999"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP1 Q3 ENGLISH.MP3", text: "Young people meet in underground places to see a real person... crying. This experience is said to cause the first shiver of feeling—an unforgettable... and forbidden sensation.", year: "2036")
                            ]),
                            FactOption(title: "Queen Victoria issues the Children's Emancipation Act", karma: 5, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP2 Q1 ENGLISH",  text: "Britain begins establishing the first free public school system.", year: "1845"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP2 Q2 ENGLISH.MP3", text: "The generation freed from childhood slavery invents alternative energy systems, reducing the exploitation of coal and mines, and reducing global warming early.", year: "1910"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP2 Q3 ENGLISH.MP3", text: "World War I broke out, but it ended quickly... because those in leadership knew the value of the childhood they had lived.", year: "1910 ")
                            ])
                        ]
                    )
                }

                if category == "Human_Rights" && mode == "Utopian/Dystopian" && language == "arabic" {
                    return FactData(
                        fact: "في العصر الفيكتوري، كان يُجبر الأطفال على العمل الشاق في المصانع والمناجم والمزارع منذ سن مبكرة، تحت ظروف غير إنسانية ودون أي حقوق.",
                        options: [
                            FactOption(title: "تصدر الحكومة مرسوماً بمشروع القضاء على الحزن", karma: 10, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP1 Q1 ARABIC.MP3", text: " اول موجة انهيار جماعي لجيل الابتسامة القسرية، يتبعها ظهور جماعة مقاومة تُدعى الباكين، يطالبون بعودة الحزن كحق إنساني", year: "١٩٥٠"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP1 Q2 ARABIC.MP3", text:  "يبدأ المرضى بحفر خدوش على وجوههم كي يخلقوا شعوراً بماضٍ لم يعد موجوداً في ذاكرتهم.", year: "١٩٩٩"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP1 Q3 ARABIC.MP3", text: " يلتقي الشباب في أماكن سرّية لرؤية شخص حقيقي... يبكي. هذه التجربة توصف بأنها أول رعشة شعور — إحساس لا يُنسى... ومحظور."
                                         , year: "٢٠٣٦")
                            ]),
                            FactOption(title: "سنّ قانون يمنع تشغيل الأطفال في المصانعتصدر الملكة فيكتوريا قانون تحرير الأطفال.", karma: 5, parts: [
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP2 Q1 ARABIC .MP3", text: " تبدأ بريطانيا بتأسيس أول نظام مجاني للمدارس العامة.", year: "١٩٤٥"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP2 Q2 ARABIC.MP3", text: " الجيل الذي تحرر من العبودية في الطفولة يخترع أنظمة طاقة بديلة، مما يقلل من استغلال الفحم والمناجم، ويساهم في تقليل الاحتباس الحراري مبكرًا.", year: "١٩١٠"),
                                FactPart(sound: "HUMAN RIGHTS_Utopian: Dystopian Mode_OP2 Q3 ARABIC.MP3", text: "اندلعت الحرب العالمية الأولى، لكنها انتهت بسرعة... لأن القادة في ذلك الوقت كانوا يعرفون قيمة الطفولة التي عاشوها."
                                         , year: "١٩١٠ ")
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
