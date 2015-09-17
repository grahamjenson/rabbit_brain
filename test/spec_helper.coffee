# imports
chai = require 'chai'
should = chai.should()

global.bb = require 'bluebird'
bb.Promise.longStackTraces();


global._ = require('lodash')

# local imports
global.Perceptron = require '../perceptron'
global.InMemoryBrain = require '../in_memory_brain'


