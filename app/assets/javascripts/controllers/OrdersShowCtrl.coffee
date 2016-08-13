angular.module('MealTimeModule').controller("OrdersShowCtrl", ($scope, $stateParams, orderResource, mealResource) ->
  $scope.order = orderResource.get({id: $stateParams.id})

  $scope.updateOrder = ->
    $scope.order = orderResource.update({id: $scope.order.id}, {status: $scope.newStatus})

  $scope.addMeal = ->
    new_meal = mealResource.save({order_id: $scope.order.id}, {name: $scope.newMeal.name, price: $scope.newMeal.price})
    $scope.order.meals.push(new_meal)
    $scope.newMeal.name = ""
    $scope.newMeal.price = ""
)
