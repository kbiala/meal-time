angular.module('MealTimeModule').controller("OrdersShowCtrl", ($scope, $stateParams, orderResource) ->
  $scope.order = orderResource.get({id: $stateParams.id})
)
