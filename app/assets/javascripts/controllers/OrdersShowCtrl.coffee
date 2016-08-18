angular.module('MealTimeModule').controller("OrdersShowCtrl", ($scope, $rootScope, $stateParams, orderResource, mealResource) ->
  $scope.statuses = ['New', 'Finalized', 'Ordered', 'Delivered']
  $scope.order = orderResource.get({id: $stateParams.id, access_token: $scope.currentToken()}, (->), (response) ->
    if response.status == 401
      $scope.loginAlert()
  )

  $scope.updateOrder = (newStatus) ->
    $scope.order = orderResource.update({id: $scope.order.id}, {
      status: newStatus,
      access_token: $scope.currentToken()
    }, ->
      if newStatus == "Delivered"
        index = $rootScope.activeOrders.findIndex (order) ->
          return order == $rootScope.currentOrder
        $rootScope.activeOrders.splice(index, 1)
        $rootScope.deliveredOrders.push($scope.order)
    )

  $scope.addMeal = ->
    if !$scope.newMeal || !$scope.newMeal.name || !$scope.newMeal.price
      alert("Name and price cannot be empty")
    else
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
