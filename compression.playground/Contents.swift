import Foundation

/**
Returns a compacted array, with repeated values coalesced.
Example: [a, a, b, c, c, c] yields [(a, 2), (b, 1), (c, 3)]
*/
func compressArray<T: Comparable>(input: [T]) -> [(T, Int)] {
    var output = [(T, Int)]()
    for element in input {
        if let (value, occurrences) = output.last where value == element {
            output[output.count - 1] = (element, occurrences + 1)
        } else {
            output.append((element, 1))
        }
    }
    return output
}

/**
Returns the original, expanded form of a compressed array.
Example: [(a, 2), (b, 1), (c, 3)] yields [a, a, b, c, c, c]
*/
func decompressArray<T>(input: [(T, Int)]) -> [T] {
    return input.flatMap { (value, occurrences) in
        Repeat(count: occurrences, repeatedValue: value)
    }
}

let uncompressedInts = [
    8, 8, 8,
    2, 2, 2, 2, 2, 2, 2, 2, 2,
    8,
    3,
    5, 5, 5, 5,
    0, 0, 0, 0, 0, 0, 0,
    9]

let expectedCompressedArray = [
    (8, 3),
    (2, 9),
    (8, 1),
    (3, 1),
    (5, 4),
    (0, 7),
    (9, 1)]

let compressedArray = compressArray(uncompressedInts)
let isCompressionCorrect = compressedArray.elementsEqual(expectedCompressedArray) {
    $0.0 == $1.0 && $0.1 == $1.1
}
if isCompressionCorrect {
    print("Compression success!")
} else {
    print("Compression failure: \(compressedArray)")
}

let decompressedArray = decompressArray(compressedArray)
let isDecompressionCorrect = decompressedArray == uncompressedInts
if isDecompressionCorrect {
    print("Decompression success!")
} else {
    print("Decompression failure: \(decompressedArray)")
}
