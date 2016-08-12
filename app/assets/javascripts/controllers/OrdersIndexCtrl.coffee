angular.module('MealTimeModule').controller("OrdersIndexCtrl", ($scope, orderResource) ->
  $scope.orders = orderResource.query()

  $scope.addOrder = ->
    order = orderResource.save($scope.newOrder)
    $scope.orders.push(order)
    $scope.newOrder = {}
)
