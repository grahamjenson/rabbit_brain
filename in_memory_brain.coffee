class InMemoryBrain
  constructor: () ->
    @perceptrons = {}

  add: (perceptron) ->
    @perceptrons[perceptron.uuid] = perceptron

  send_charge: (from, to, charge) ->
    @perceptrons[to].receive_charge(from, charge)

  send_backpropagation: (from, to, error, charge) ->
    @perceptrons[to].receive_backpropagation(from, error, charge)


module.exports = InMemoryBrain