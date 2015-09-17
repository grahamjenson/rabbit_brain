#Worked Example 3.1 from https://www4.rgu.ac.uk/files/chapter3%20-%20bp.pdf
describe 'basic pattern matching example', ->
  it 'should learn and match', ->
    test_data = [
      {
        input: [0,1,1,0]
        output: [0,1]
      }
    ]

    network = {
      i1: ['a', 'b', 'c']
      i2: ['a', 'b', 'c']
    }
    