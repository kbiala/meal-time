angular.module('MealTimeModule').controller("OrdersShowCtrl", ($scope, $stateParams, orderResource, mealResource) ->
  $scope.statuses = ['New', 'Finalized', 'Ordered', 'Delivered']
  $scope.order = orderResource.get({id: $stateParams.id, access_token: $scope.currentToken()})

  $scope.updateOrder = (newStatus) ->
    $scope.order = orderResource.update({id: $scope.order.id}, {
      status: newStatus,
      access_token: $scope.currentToken()
    })

  $scope.addMeal = ->
    new_meal = mealResource.save({order_id: $scope.order.id}, {
      name: $scope.newMeal.name,
      price: $scope.newMeal.price,
      access_token: $scope.currentToken()
      }, ->
        $scope.order.meals.push(new_meal)
      , (response) ->
        console.log response
        alert(response.data.error)
    )
    $scope.newMeal.name = ""
    $scope.newMeal.price = ""
)
