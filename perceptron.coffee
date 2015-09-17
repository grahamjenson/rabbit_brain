# Based on https://www.youtube.com/watch?v=q0pm3BrIUFo
# and https://www4.rgu.ac.uk/files/chapter3%20-%20bp.pdf
bb = require 'bluebird'

class AsyncPerceptron
  # A perceptron knows who it is connected to and by what weights
  # it does not know who connects to it and by what weights
  # But if it recieves a message on

  constructor: (@uuid, @brain, @synapses = {}) ->
    @brain.add(@)

    @activation_energy = 0.01 #diff to send new value
    @active_time = 10 #ms, time to store input
    @current_chargers = {}
    @timers = {}

  receive_charge: (from, charge) ->
    console.log "P #{@uuid} receive_charge #{charge} from #{from}"
    time = new Date().getTime()
    @increase_charge(from, charge)
    current_charge = @current_charge()
    for to, weight of @synapses
      charge_to_send = @calculate_charge(current_charge, weight)
      if Math.abs(charge_to_send) > @activation_energy 
        @brain.send_charge(@uuid, to, charge_to_send)

  current_charge: ->
    total = 0
    for from, value of @current_chargers
      total += value

    console.log "P #{@uuid} current charge is now #{total}"
    total

  increase_charge: (from, value) ->
    #this is a simple little function that removes the charge
    #TODO make this a smooth function so charge decreases slowly

    @current_chargers[from] = value
    timer = bb.delay(@active_time)
    timer.cancellable()
    timer.catch(bb.CancellationError, (e) ->
      console.log e
    )

    if @timers[from]
      @timers[from].cancel()

    @timers[from] = timer

    timer.then( =>
      delete @current_chargers[from]
      delete @timers[from]
      @current_charge()
    )
    .catch(bb.CancellationError, (e) ->
      console.log e
    )

  calculate_charge: (value, weight) ->
    return value * weight
    # #weight * sigmoid function weight * (1 / (1+ Math.pow(Math.E, - value)))

  ####################################
  ###       Backpropagation        ###
  ####################################

  receive_backpropagation: (from, error, charge) ->
    console.log "P #{@uuid} receive_backpropagation of error #{error} and charge #{charge} from #{from}"
    error_a = charge * (1 - charge) * error * weights[x]

    @brain.send_backpropagation(@uuid, to, error, sent_value)

  error_a: (output_a) ->
    total_error = 0
    for w_ax in weights
      total_error = total_error + (error_x * w_ax)

    output * (1 - output) * total_error

  new_weight_ab: (current_weight_ab, error_b, output_a) ->
    current_weight_ab + (error_b * output_a)

module.exports = AsyncPerceptron