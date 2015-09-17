#Worked Example 3.1 from https://www4.rgu.ac.uk/files/chapter3%20-%20bp.pdf
describe 'testing forward propagation, and backward learning', ->
  it 'should forward propagate correctly', ->
    in_memory_brain = new InMemoryBrain()
    a = new Perceptron('a', in_memory_brain, {'h1': 0.1, 'h2': 0.4})
    b = new Perceptron('b', in_memory_brain, {'h1': 0.8, 'h2': 0.6})

    h1 = new Perceptron('h1', in_memory_brain, {'o': 0.3})
    h2 = new Perceptron('h2', in_memory_brain, {'o': 0.9})

    output = new Perceptron('o', in_memory_brain)


    in_memory_brain.send_charge(null, 'a', 0.35)
    in_memory_brain.send_charge(null, 'b', 0.9)
    bb.delay(2)
    .then( ->
      output.current_charge().should.equal 0.69
    )

    