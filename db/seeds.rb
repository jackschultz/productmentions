# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

reddit = Site.find_or_create_by(name: "Reddit", url: "https://www.reddit.com/")

books = Subsite.find_or_create_by(name: "Books", url: "https://www.reddit.com/r/books/", site: reddit)
fitness = Subsite.find_or_create_by(name: "Fitness", url: "https://www.reddit.com/r/fitness/", site: reddit)

book = ProductGroup.find_or_create_by(amazon_name: "Book", name: "Books")

joking = Product.find_or_create_by(asin: "0393316041", title: "Surely You're Joking, Mr. Feynman! (Adventures of a Curious Character)",
                        product_group: book,
                        url: "https://www.amazon.com/Surely-Feynman-Adventures-Curious-Character/dp/0393316041")

east_of_eden = Product.find_or_create_by(asin: "0140186395", title: "East of Eden (Penguin Twentieth Century Classics)",
                        product_group: book,
                        url: "https://www.amazon.com/East-Penguin-Twentieth-Century-Classics/dp/0140186395/")

catch_22 = Product.find_or_create_by(asin: "1451626657", title: "Catch-22: 50th Anniversary Edition",
                        product_group: book,
                        url: "https://www.amazon.com/Catch-22-50th-Anniversary-Joseph-Heller/dp/1451626657/")


joking_comment_text = <<eos
"I've always tried to limit myself to one book at a time, but I end up picking up others.\n\n* I'm halfway through [*Foucault's Pendulum*](http://www.amazon.com/Foucaults-Pendulum-Umberto-Eco/dp/015603297X/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1325788281&amp;sr=1-1). The first half has been interesting at times and dull at others, but I want to finish it. \n* I'm also reading [*A Walk in the Woods*](http://www.amazon.com/Walk-Woods-Rediscovering-Appalachian-Official/dp/0767902521) and enjoying it immensely.\n* I'm reading a short collection of stories by Bosnian/Croatian writer [Miljenko Jergovic](http://www.goodreads.com/book/show/6041138-drugi-poljubac-gite-danon), on and off.\n* Recently half done but finished: [Fight: Everything You Ever Wanted to Know About Ass-Kicking but Were Afraid You'd Get Your Ass Kicked for Asking](http://www.amazon.com/Fight-Everything-Wanted-Ass-Kicking-Afraid/dp/0061189227/ref=sr_1_2?s=books&amp;ie=UTF8&amp;qid=1325788026&amp;sr=1-2) and [Mindfulness in Plain English](http://www.amazon.com/Mindfulness-Plain-English-Revised-Expanded/dp/0861713214)\n* Oh yeah. Also read a few short stories from [Surely You're Joking, Mr. Feynman!](http://www.amazon.com/Surely-Feynman-Adventures-Curious-Character/dp/0393316041)\n\nIt kills me to start books before I finish others, but I can't help it. Besides, some books are hard to finish, but it pays off in the end. On that topic, is *Foucault's Pendulum* worth it? I'm only halfway through and the story has hardly begun.\n\nSo, how many books will you read at the same time?"
eos

joking_comment = Comment.find_or_create_by(subsite: books, url: "https://www.reddit.com/r/books/comments/o48sg/how_many_books_do_you_read_at_the_same_time/", username: "smekas", text: joking_comment_text)

joking_mention = Mention.find_or_create_by(product: joking, comment: joking_comment)

catch_22_comment_text = <<eos
"A couple months ago I made a [post](http://www.reddit.com/r/books/comments/e6z74/a_book_from_az/) asking for suggestions for me and my girlfriend to read over the year.  After a lot of research and deliberation these are the books we've decided to read.\n\nA – [Along Came a Spider](http://www.amazon.ca/Along-Came-Spider-James-Patterson/dp/0446364193/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294932986&amp;sr=1-1)\n\nB - [The Brief Wondrous Life of Oscar Wao](http://www.amazon.ca/Brief-Wonderous-Oscar-Unabridged-Compact/dp/0143142801/ref=sr_1_1?ie=UTF8&amp;s=books&amp;qid=1294933051&amp;sr=1-1)\n\nC – [Catch 22](http://www.amazon.ca/Catch-22-Joseph-Heller/dp/0684833395/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933075&amp;sr=1-1)\n\nD – [Devil in the White City](http://www.amazon.ca/Devil-White-City-Madness-Changed/dp/0375725601/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933105&amp;sr=1-1)\n\nE – [Ella Enchanted](http://www.amazon.ca/Ella-Enchanted-Levine/dp/0064407055/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933125&amp;sr=1-1)\n\nF – [Fahrenheit 451](http://www.amazon.ca/Fahrenheit-451-Ray-Bradbury/dp/0345342968/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933198&amp;sr=1-1)\n\nG – [Grimm’s Fairy Tales](http://www.amazon.ca/Complete-Grimms-Fairy-Tales/dp/0394709306/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933229&amp;sr=1-1) (Not sure if it's all of them.  The book was borrowed)\n\nH – [Hunger Games](http://www.amazon.ca/Hunger-Games-Suzanne-Collins/dp/0439023521/ref=sr_1_2?s=books&amp;ie=UTF8&amp;qid=1294933298&amp;sr=1-2)\n\nI – [I’d Know You Anywhere](http://www.amazon.ca/Id-Know-You-Anywhere-Novel/dp/0061706558/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933318&amp;sr=1-1)\n\nJ – [Jennifer Government](http://www.amazon.ca/Jennifer-Government-Max-Barry/dp/1400030927/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933354&amp;sr=1-1)\n\nK – [Keep the Aspidistra Flying](http://www.amazon.ca/Keep-Aspidistra-Flying-Orwell/dp/0156468999/ref=sr_1_2?s=books&amp;ie=UTF8&amp;qid=1294933397&amp;sr=1-2)\n\nL – [Let the Right One In](http://www.amazon.ca/Let-Right-John-Ajvide-Lindqvist/dp/1847241700/ref=sr_1_3?ie=UTF8&amp;qid=1294933435&amp;sr=1-3)\n\nM – [Misery](http://www.amazon.ca/Misery-Stephen-King/dp/0451169522/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933462&amp;sr=1-1)\n\nN – [Never Let Me Go](http://www.amazon.ca/Never-Let-Me-Kazuo-Ishiguro/dp/0676977103/ref=sr_1_3?s=books&amp;ie=UTF8&amp;qid=1294933487&amp;sr=1-3)\n\nO – [One Day](http://www.amazon.ca/One-Day-David-Nicholls/dp/0307474712/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933520&amp;sr=1-1)\n\nP – [Palo Alto: Stories](http://www.amazon.ca/Palo-Alto-Stories-James-Franco/dp/1439163146/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933555&amp;sr=1-1)\n\nQ – [Quidditch through the Ages](http://www.amazon.ca/Quidditch-Through-Ages-J-Rowling/dp/140880302X/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933601&amp;sr=1-1)\n\nR – [Room](http://www.amazon.ca/Room-Emma-Donoghue/dp/1554688310/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933623&amp;sr=1-1)\n\nS – [The Sun Also Rises](http://www.amazon.ca/Sun-Also-Rises-Ernest-Hemingway/dp/0743297334/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933644&amp;sr=1-1)\n\nT – [Thank You for Smoking](http://www.amazon.ca/Thank-You-Smoking-Christopher-Buckley/dp/0812976525/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933670&amp;sr=1-1)\n \nU – [Unwind](http://www.amazon.ca/Unwind-Neal-Shusterman/dp/1416912053/ref=sr_1_1?s=books&amp;ie=UTF8&amp;qid=1294933699&amp;sr=1-1)\n\nV – [Vernon God Little](http://www.amazon.ca/Vernon-God-Little-Dbc-Pierre/dp/0571215165/ref=sr_1_1?ie=UTF8&amp;s=books&amp;qid=1294933738&amp;sr=1-1)\n\nW – [Watership Down](http://www.amazon.ca/Watership-Down-Richard-Adams/dp/0140306013/ref=sr_1_1?ie=UTF8&amp;s=books&amp;qid=1294933762&amp;sr=1-1)\n\nX – [X Saves the World](http://www.amazon.ca/X-Saves-World-Jeff-Gordinier/dp/0670018589/ref=sr_1_2?ie=UTF8&amp;s=books&amp;qid=1294933802&amp;sr=1-2)\n\nY – [Youth in Revolt](http://www.amazon.ca/Youth-Revolt-C-D-Payne/dp/0385481969/ref=sr_1_1?ie=UTF8&amp;s=books&amp;qid=1294933834&amp;sr=1-1)\n\nZ – [Zombie](http://www.amazon.ca/Zombie-Novel-Joyce-C-Oates/dp/0061778915/ref=sr_1_27?s=books&amp;ie=UTF8&amp;qid=1294933865&amp;sr=1-27) \n\n**Edit -** I forgot to mention I'll be doing a [BooksAMA](http://www.reddit.com/r/booksama) for each book."
eos

# => Comment(id: integer, subsite_id: integer, url: string, username: string, text: string, written_at: datetime, created_at: datetime, upda
catch_22_comment = Comment.find_or_create_by(subsite: books, url: "https://www.reddit.com/r/books/comments/f1lv5/my_book_project_for_the_year_a_book_from_az/", username: "Pudie", text: catch_22_comment_text)

# => Mention(id: integer, product_id: integer, comment_id: integer, created_at: datetime, updated_at: datetime)
catch_22_mention = Mention.find_or_create_by(product: catch_22, comment: catch_22_comment)
