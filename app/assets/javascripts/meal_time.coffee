# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("MealTimeModule", ["ngResource"])

app.factory "orderResource", ($resource) ->
  $resource("/orders/:id", {id: "@id"}, {update: {method: "PUT"}})

app.controller("MealTimeCtrl", ($scope, orderResource) ->
  $scope.orders = orderResource.query()

  $scope.addOrder = ->
    order = orderResource.save($scope.newOrder)
    $scope.orders.push(order)
    $scope.newOrder = {}
)
