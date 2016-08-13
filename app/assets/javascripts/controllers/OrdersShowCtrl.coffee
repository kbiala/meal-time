angular.module('MealTimeModule').controller("OrdersShowCtrl", ($scope, $stateParams, orderResource) ->
  $scope.order = orderResource.get({id: $stateParams.id})

  $scope.updateOrder = ->
    $scope.order = orderResource.update({id: $scope.order.id}, {status: $scope.newStatus})
)
