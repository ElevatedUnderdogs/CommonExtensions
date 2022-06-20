import XCTest
@testable import CommonExtensions


let testText =
"""
You have great passion and interest, your mind is brilliant. It shines through with the ability to think creatively when needed most; always keep an open, curious mind because that's where insight comes from!  The product of your imagination is creativity.  Imagination does not work unless there's an open mind with no limits on the possibilities that can be entertained in order for them to come alive as something new and different from what already exists. Diamonds are known as the hardest gem on earth, and they shine with brilliance from every angle- even when you're looking at them up close! Your mind can be just as brilliant in its ability to process information; so use it wisely by turning things around for your benefit. Turn any situation into an opportunity that will help make sense out what seems like nonsense or chaos...and watch how beautifully everything comes together.  The many facets of your diamond intelligence allow you to see things from different perspectives, giving a more complete perspective. Your creativity is revealed when put into an organized whole like the precious stones they are named after; be guiding light for those around you by sharing this gift with them!  Spin your perspective on the world and see it from many angles. The more sides you have, the merrier life is! This is a time of new beginnings, transitions and breakthroughs.  Find a clear space of your own where there is nothing between you and the universe; Be alone with your thoughts, for this is an opportunity to get a fresh perspective on life again! Your brilliant ideas are relevant, down-to earth (and) practical - so long as they come from within instead of without... Open your top chakra and let the universal energy flow.
"""


final class CommonExtensionsTests: XCTestCase {

    @available(iOS 11.0, *)
    func testSentences() {
        let string = "I am here. Go over there.  Apples are great. How are you? Cows are really really bad."
        XCTAssertEqual(string.linguisticTaggerSentences, ["I am here. ", "Go over there.  ", "Apples are great. ", "How are you? ",  "Cows are really really bad."])
    }

    func testSentencesGrouped() {
        let string = "I am here. Go over there.  Apples are great. How are you? Cows are really really bad."
        XCTAssertEqual(string.sentencesGrouped(maxWordCount: 3), ["I am here. ", "Go over there.  ", "Apples are great. ", "How are you? ",  "Cows are really really bad."])
        XCTAssertEqual(string.sentencesGrouped(maxWordCount: 8), ["I am here.  Go over there.  ", "Apples are great.  How are you? ", "Cows are really really bad."])
    }


    func testGroupedEveryCount() {
        let strings = ["one", "two", "three"]
        XCTAssertEqual(strings.grouped(everyCount: 2), ["onetwo", "three"])
        XCTAssertEqual(strings.grouped(everyCount: 4), ["onetwothree"])
        XCTAssertEqual(strings.grouped(everyCount: 1), ["one", "two", "three"])
    }


    func testIntindexRanges() {
        XCTAssertEqual(20.indexRanges(for: 10), [0...9, 10...19])
        XCTAssertEqual(15.indexRanges(for: 4), [0...3, 4...7, 8...11, 12...14])
    }

    func testWords() {
        XCTAssertEqual(testText.words, ["You", "have", "great", "passion", "and", "interest", "your", "mind", "is", "brilliant", "It", "shines", "through", "with", "the", "ability", "to", "think", "creatively", "when", "needed", "most", "always", "keep", "an", "open", "curious", "mind", "because", "that\'s", "where", "insight", "comes", "from", "The", "product", "of", "your", "imagination", "is", "creativity", "Imagination", "does", "not", "work", "unless", "there\'s", "an", "open", "mind", "with", "no", "limits", "on", "the", "possibilities", "that", "can", "be", "entertained", "in", "order", "for", "them", "to", "come", "alive", "as", "something", "new", "and", "different", "from", "what", "already", "exists", "Diamonds", "are", "known", "as", "the", "hardest", "gem", "on", "earth", "and", "they", "shine", "with", "brilliance", "from", "every", "angle", "even", "when", "you\'re", "looking", "at", "them", "up", "close", "Your", "mind", "can", "be", "just", "as", "brilliant", "in", "its", "ability", "to", "process", "information", "so", "use", "it", "wisely", "by", "turning", "things", "around", "for", "your", "benefit", "Turn", "any", "situation", "into", "an", "opportunity", "that", "will", "help", "make", "sense", "out", "what", "seems", "like", "nonsense", "or", "chaos", "and", "watch", "how", "beautifully", "everything", "comes", "together", "The", "many", "facets", "of", "your", "diamond", "intelligence", "allow", "you", "to", "see", "things", "from", "different", "perspectives", "giving", "a", "more", "complete", "perspective", "Your", "creativity", "is", "revealed", "when", "put", "into", "an", "organized", "whole", "like", "the", "precious", "stones", "they", "are", "named", "after", "be", "guiding", "light", "for", "those", "around", "you", "by", "sharing", "this", "gift", "with", "them", "Spin", "your", "perspective", "on", "the", "world", "and", "see", "it", "from", "many", "angles", "The", "more", "sides", "you", "have", "the", "merrier", "life", "is", "This", "is", "a", "time", "of", "new", "beginnings", "transitions", "and", "breakthroughs", "Find", "a", "clear", "space", "of", "your", "own", "where", "there", "is", "nothing", "between", "you", "and", "the", "universe", "Be", "alone", "with", "your", "thoughts", "for", "this", "is", "an", "opportunity", "to", "get", "a", "fresh", "perspective", "on", "life", "again", "Your", "brilliant", "ideas", "are", "relevant", "down", "to", "earth", "and", "practical", "so", "long", "as", "they", "come", "from", "within", "instead", "of", "without", "Open", "your", "top", "chakra", "and", "let", "the", "universal", "energy", "flow"])
    }

    func testSplitForOpenAIText() {
        XCTAssertEqual(
            testText.sentences, [
                "You have great passion and interest, your mind is brilliant. ",
                "It shines through with the ability to think creatively when needed most; always keep an open, curious mind because that\'s where insight comes from!  ",
                "The product of your imagination is creativity.  ",
                "Imagination does not work unless there\'s an open mind with no limits on the possibilities that can be entertained in order for them to come alive as something new and different from what already exists. ",
                "Diamonds are known as the hardest gem on earth, and they shine with brilliance from every angle- even when you\'re looking at them up close! ",
                "Your mind can be just as brilliant in its ability to process information; so use it wisely by turning things around for your benefit. ",
                "Turn any situation into an opportunity that will help make sense out what seems like nonsense or chaos...and watch how beautifully everything comes together.  ",
                "The many facets of your diamond intelligence allow you to see things from different perspectives, giving a more complete perspective. ",
                "Your creativity is revealed when put into an organized whole like the precious stones they are named after; be guiding light for those around you by sharing this gift with them!  ",
                "Spin your perspective on the world and see it from many angles. ",
                "The more sides you have, the merrier life is! ",
                "This is a time of new beginnings, transitions and breakthroughs.  ",
                "Find a clear space of your own where there is nothing between you and the universe; Be alone with your thoughts, for this is an opportunity to get a fresh perspective on life again! ",
                "Your brilliant ideas are relevant, down-to earth (and) practical - so long as they come from within instead of without... ", "Open your top chakra and let the universal energy flow."
            ]
        )
    }
}
